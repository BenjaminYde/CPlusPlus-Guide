#include "01_sync.h"
#include "02_async.h"
#include "03_async_cout_mutex.h"

int main()
{
    Program_01_async Program_01_async;
    //Program_01_async.Run();

    Program_02_async Program_02_async;
    //Program_02_async.Run();

    Program_03_async_cout_mutex Program_03_async_cout_mutex;
    Program_03_async_cout_mutex.Run();

    return 0;
}