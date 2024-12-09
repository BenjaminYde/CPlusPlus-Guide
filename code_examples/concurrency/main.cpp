#include "01_sync.h"
#include "02_async.h"
#include "03_async_cout_mutex.h"
#include <format>

int main()
{
    int programId = 3;
    std::cout << std::format("Running program , {}...", programId) << std::endl;

    switch (programId)
    {
    case 1:
        Program_01_async Program_01_async;
        Program_01_async.Run();
        break;
    case 2:
        Program_02_async Program_02_async;
        Program_02_async.Run();
        break;
    case 3:
        Program_03_async_cout_mutex Program_03_async_cout_mutex;
        Program_03_async_cout_mutex.Run();
        break;
    }

    return 0;
}