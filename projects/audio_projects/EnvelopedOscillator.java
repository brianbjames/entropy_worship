import javax.sound.sampled.*;
import java.util.Arrays;

public class EnvelopedOscillator {

    // Constants for audio parameters
    private static final float SAMPLE_RATE = 44100.0f; // Sample rate in Hz
    private static final int BUFFER_SIZE = 4096; // Buffer size for audio playback

    // Frequency of the oscillator (e.g., 440 Hz for A4 note)
    private static final double FREQUENCY = 220.0; // A4 Note, change to experiment with different frequencies

    // ADSR envelope parameters (time in milliseconds)
    private static final int ATTACK_TIME = 200;    // Attack time in ms
    private static final int DECAY_TIME = 300;     // Decay time in ms
    private static final float SUSTAIN_LEVEL = 0.6f; // Sustain level (0.0 to 1.0)
    private static final int RELEASE_TIME = 400;   // Release time in ms

    // Generate a sine wave with the given frequency and duration
    private static byte[] generateSineWave(double frequency, float sampleRate, int durationMillis, boolean applyEnvelope) {
        int numSamples = (int) (sampleRate * durationMillis / 1000);
        byte[] data = new byte[numSamples];
        double[] envelope = new double[numSamples];

        // Apply the ADSR envelope if requested
        if (applyEnvelope) {
            // Calculate envelope for each sample
            for (int i = 0; i < numSamples; i++) {
                double time = (i / sampleRate) * 1000; // Time in milliseconds

                // Attack phase (0 to 1)
                if (time < ATTACK_TIME) {
                    envelope[i] = (double) time / ATTACK_TIME;
                }
                // Decay phase (max to sustain)
                else if (time < (ATTACK_TIME + DECAY_TIME)) {
                    envelope[i] = 1.0 - (1.0 - SUSTAIN_LEVEL) * ((time - ATTACK_TIME) / DECAY_TIME);
                }
                // Sustain phase (sustain level)
                else if (time < (durationMillis - RELEASE_TIME)) {
                    envelope[i] = SUSTAIN_LEVEL;
                }
                // Release phase (sustain to 0)
                else {
                    envelope[i] = SUSTAIN_LEVEL * (1 - ((time - (durationMillis - RELEASE_TIME)) / RELEASE_TIME));
                }
            }
        } else {
            // No envelope, just a pure sine wave with constant volume
            Arrays.fill(envelope, 1.0);
        }

        // Generate sine wave with applied envelope
        for (int i = 0; i < numSamples; i++) {
            double angle = 2.0 * Math.PI * i * frequency / sampleRate;
            data[i] = (byte) (Math.sin(angle) * 127f * envelope[i]); // Apply envelope scaling
        }

        return data;
    }

    public static void main(String[] args) {
        try {
            // Generate a sine wave with the desired frequency (e.g., 440 Hz for A4)
            byte[] sineWave = generateSineWave(FREQUENCY, SAMPLE_RATE, 1500, true); // 1.5 seconds with envelope

            // Create an AudioFormat for PCM signed 8-bit mono audio at the sample rate
            AudioFormat audioFormat = new AudioFormat(SAMPLE_RATE, 8, 1, true, false);

            // Set up a DataLine.Info object for the clip (the audio output)
            DataLine.Info info = new DataLine.Info(Clip.class, audioFormat);

            // Open the audio clip and load the generated sine wave data
            Clip clip = (Clip) AudioSystem.getLine(info);
            clip.open(audioFormat, sineWave, 0, sineWave.length);

            // Start playing the sound
            clip.start();

            // Keep the program running while the clip plays
            System.out.println("Playing enveloped oscillator...");
            Thread.sleep(1500);  // Sleep for the duration of the sound (1500 ms = 1.5 seconds)

            // Close the clip after playing
            clip.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
