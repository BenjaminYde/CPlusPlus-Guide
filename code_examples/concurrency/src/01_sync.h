#include <iostream>
#include <thread>
#include <chrono>

class Program_01_async 
{
public:
    void Run() 
    {
         auto start = std::chrono::high_resolution_clock::now();

        CreateCoffee();
        CreateToast();

        auto stop = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::seconds>(stop - start);

        std::cout << "Total time = " << duration.count() << " seconds" << std::endl;
    }

private:
    void CreateCoffee()
    {
        std::cout << "Creating coffee..." << std::endl;
        std::this_thread::sleep_for(std::chrono::milliseconds(2000));
        std::cout << "Created coffee!" << std::endl;
    }

    void CreateToast()
    {
        std::cout << "Creating toast..." << std::endl;
        std::this_thread::sleep_for(std::chrono::milliseconds(3000));
        std::cout << "Created toast!" << std::endl;
    }
};
