package polimorfologik.tests;

import static org.assertj.core.api.Assertions.assertThat;

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

public class TestSynthesis extends RandomizedTest {
  private static DictionaryLookup dict;
  private static Path input;

  @BeforeClass
  public static void setupDictionary() throws Exception {
    String synthDict = System.getProperty("polish_synth.dict");
    assumeNotNull(synthDict);

    assertThat(Paths.get(synthDict).toAbsolutePath()).exists();
    dict = new DictionaryLookup(Dictionary.read(Paths.get(synthDict)));

    String combinedInput = System.getProperty("combined.input");
    assumeNotNull(combinedInput);
    input = Paths.get(combinedInput);
  }

  @Test
  public void testAllEntriesInDictionary() throws Exception {
    final char separator = dict.getDictionary().metadata.getSeparatorAsChar();
    Pattern p = Pattern.compile(Pattern.quote(Character.toString(separator)));
    Pattern tagSeparator = Pattern.compile("\\+");
    Pattern ignoredTags = Pattern.compile(":neg|qub|depr");
    Files.lines(input, StandardCharsets.UTF_8)
      .forEach((line) -> {
        String[] columns = p.split(line);
        assertThat(columns).hasSize(3);

        String stem = columns[0];
        String inflected = columns[1];
        String [] tags = tagSeparator.split(columns[2]);

        for (String tag : tags) {
          if (ignoredTags.matcher(tag).find()) {
            continue;
          }

          assertThat(inflectedOf(stem, tag))
            .as(line)
            .contains(inflected);
        }
      });
  }

  @Test
  public void sanityCheck() throws Exception {
    assertThat(inflectedOf("krowa", "subst:pl:inst:f"))
      .containsExactly("krowami");
  }

  private static List<String> inflectedOf(String word, String tag) {
    return dict.lookup(word + "|" + tag).stream()
        .map((wd) -> wd.getStem().toString())
        .collect(Collectors.toList());
  }
}
