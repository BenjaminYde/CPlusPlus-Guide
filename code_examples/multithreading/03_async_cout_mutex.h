#include <iostream>
#include <thread>
#include <future>
#include <chrono>

std::mutex coutMutex;  // global mutex for synchronized console output

class Program_03_async_cout_mutex
{
public:
    void Run() 
    {
        auto start = std::chrono::high_resolution_clock::now();

        auto coffee_future = CreateCoffee();
        auto toast_future = CreateToast();

        coffee_future.get();
        toast_future.get();

        auto stop = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::seconds>(stop - start);

        std::cout << "Total time = " << duration.count() << " seconds" << std::endl;
    }

private:
    std::future<void> CreateCoffee()
    {
        return std::async([](){
            {
                std::lock_guard<std::mutex> lock(coutMutex);
                std::cout << "Creating coffee..." << std::endl;
            }
            std::this_thread::sleep_for(std::chrono::milliseconds(2000));
            std::cout << "Created coffee!" << std::endl;
        });
    }

    std::future<void> CreateToast()
    {
        return std::async([](){
            {
                std::lock_guard<std::mutex> lock(coutMutex);
                std::cout << "Creating toast..." << std::endl;
            }
            std::this_thread::sleep_for(std::chrono::milliseconds(3000));
            std::cout << "Created toast!" << std::endl;
        });
    }
};