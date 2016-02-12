package polimorfologik.tests;

import static org.assertj.core.api.Assertions.*;

import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import org.junit.BeforeClass;
import org.junit.Test;

import com.carrotsearch.randomizedtesting.RandomizedTest;

import morfologik.stemming.Dictionary;
import morfologik.stemming.DictionaryLookup;

public class TestStemmingDictionary extends RandomizedTest {
  private static DictionaryLookup dict;
  private static Path input;

  @BeforeClass
  public static void setupDictionary() throws Exception {
    String polishDict = System.getProperty("polish.dict");
    assumeNotNull(polishDict);
    
    assertThat(Paths.get(polishDict).toAbsolutePath()).exists();
    dict = new DictionaryLookup(Dictionary.read(Paths.get(polishDict)));

    String combinedInput = System.getProperty("combined.input");
    assumeNotNull(combinedInput);
    input = Paths.get(combinedInput);
  }

  @Test
  public void testAllEntriesInDictionary() throws Exception {
    final char separator = dict.getDictionary().metadata.getSeparatorAsChar();
    Pattern p = Pattern.compile(Pattern.quote(Character.toString(separator)));
    Files.lines(input, StandardCharsets.UTF_8)
      .forEach((line) -> {
        String[] columns = p.split(line);
        assertThat(columns).hasSize(3);

        String stem = columns[0];
        String inflected = columns[1];
        String tags = columns[2];

        boolean found = dict.lookup(inflected).stream()
            .anyMatch((wd) -> {
              return wd.getStem().toString().equals(stem) &&
                     wd.getTag().toString().equals(tags); 
            });

        if (!found) {
          fail("No dictionary entry for: " + line);
        }
      });
  }

  @Test
  public void sanityCheck() throws Exception {
    assertThat(stemsOf("planetariów")).containsExactly("planetarium");
    assertThat(stemsOf("krowami")).containsExactly("krowa");
    assertThat(tagsOf("krowami")).containsExactly("subst:pl:inst:f");
  }

  private static List<String> stemsOf(String word) {
    return dict.lookup(word).stream()
        .map((wd) -> wd.getStem().toString())
        .collect(Collectors.toList());
  }

  private static List<String> tagsOf(String word) {
    return dict.lookup(word).stream()
        .map((wd) -> wd.getTag().toString())
        .collect(Collectors.toList());
  }    
}
