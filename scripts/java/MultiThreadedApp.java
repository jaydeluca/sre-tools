import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class MultiThreadedApp {
    private static final int QUEUE_CAPACITY  = 10000;
    private static final ArrayBlockingQueue<String> queue = new ArrayBlockingQueue<>(QUEUE_CAPACITY);

    private static void checkQueue() {
        try {
            while (true) {
                System.out.println("Current queue count: " + queue.stream().count());
                Thread.sleep(5000);
            }
        } catch (InterruptedException ignored) {
        }
    }

    private static void populateQueue() {
        int i = 0;
        try {
            while (true) {
                i++;
                queue.add("Test " + String.valueOf(i));
                Thread.sleep(1000);
            }
        } catch (InterruptedException ignored) {
        }
    }

    public static void main(String[] args) throws InterruptedException {
        ExecutorService executorService = Executors.newFixedThreadPool(4);

        // populate queue
        for (int x = 0; x < 3; x++) {
            executorService.execute(()->{
                System.out.printf("starting population task thread %s%n", Thread.currentThread().getName());
                populateQueue();
            });
        }

        // check queue length periodically
        executorService.execute(()->{
            System.out.printf("starting queue length checker task thread %s%n", Thread.currentThread().getName());
            checkQueue();
        });
    }
}
