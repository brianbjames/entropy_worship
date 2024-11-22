import javax.sound.sampled.*;
import java.util.Arrays;

public class Oscillator {

    // Constants for audio parameters
    private static final float SAMPLE_RATE = 44100; // Sample rate in Hz
    private static final int BUFFER_SIZE = 4096; // Buffer size for audio playback

    // Frequency of the oscillator (e.g., 440 Hz for A4 note)
    private static final double FREQUENCY = 440.0; // A4 Note, change to experiment with different frequencies

    // Generate a sine wave with the given frequency and duration
    private static byte[] generateSineWave(double frequency, float sampleRate, int durationMillis) {
        int numSamples = (int) (sampleRate * durationMillis / 1000);
        byte[] data = new byte[numSamples];
        
        for (int i = 0; i < numSamples; i++) {
            double angle = 2.0 * Math.PI * i * frequency / sampleRate;
            data[i] = (byte) (Math.sin(angle) * 127f); // Convert to byte format (-128 to 127)
        }
        
        return data;
    }

    public static void main(String[] args) {
        try {
            // Generate a sine wave with the desired frequency (e.g., 440 Hz for A4)
            byte[] sineWave = generateSineWave(FREQUENCY, SAMPLE_RATE, 1000); // 1-second duration

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
            System.out.println("Playing oscillator...");
            Thread.sleep(1000);  // Sleep for the duration of the sound (1000 ms = 1 second)

            // Close the clip after playing
            clip.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
