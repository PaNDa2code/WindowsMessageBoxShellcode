#include <windows.h>
#include <winternl.h>

unsigned char shellcode[] =
    "\x41\x56\x41\x55\x41\x54\x55\x57\x56\x53\x48\x83\xec\x60\xbd\x02"
    "\x00\x00\x00\x48\x8d\x74\x24\x30\x4c\x8d\x4c\x24\x53\x48\xb8\x4c"
    "\x6f\x61\x64\x4c\x69\x62\x72\x48\x89\x44\x24\x53\x48\x8d\x5c\x24"
    "\x3b\x48\xb8\x69\x62\x72\x61\x72\x79\x41\x00\x48\x89\x44\x24\x58"
    "\x48\xb8\x4d\x65\x73\x73\x61\x67\x65\x42\x48\x89\x44\x24\x3b\x48"
    "\xb8\x75\x73\x65\x72\x33\x32\x2e\x64\x48\x89\x44\x24\x30\x48\xb8"
    "\x48\x65\x6c\x6c\x6f\x57\x6f\x72\x48\x89\x44\x24\x47\x48\xb8\x53"
    "\x68\x65\x6c\x6c\x63\x6f\x64\x48\x89\x44\x24\x26\xb8\x65\x00\x00"
    "\x00\xc7\x44\x24\x37\x64\x6c\x6c\x00\xc7\x44\x24\x4f\x6c\x64\x21"
    "\x00\x66\x89\x44\x24\x2e\xc7\x44\x24\x43\x6f\x78\x41\x00\x65\x48"
    "\x8b\x04\x25\x60\x00\x00\x00\x48\x8b\x40\x18\x48\x8b\x40\x20\x48"
    "\x8b\x00\x48\x8b\x00\x4c\x8b\x50\x20\x49\x63\x42\x3c\x41\x8b\x84"
    "\x02\x88\x00\x00\x00\x4c\x01\xd0\x44\x8b\x70\x18\x8b\x50\x20\x44"
    "\x8b\x60\x1c\x44\x8b\x68\x24\x45\x85\xf6\x74\x3d\x45\x31\xdb\x49"
    "\x8d\x3c\x12\x46\x8b\x04\x9f\x31\xc0\x4d\x01\xd0\x41\x0f\xb6\x10"
    "\x84\xd2\x75\x13\xeb\x28\x38\xd1\x75\x16\x48\x83\xc0\x01\x41\x0f"
    "\xb6\x14\x00\x84\xd2\x74\x17\x41\x0f\xb6\x0c\x01\x84\xc9\x75\xe6"
    "\x49\x83\xc3\x01\x4d\x39\xf3\x75\xca\x45\x31\xd2\xeb\x1b\x41\x80"
    "\x3c\x01\x00\x75\xeb\x4b\x8d\x04\x5a\x42\x0f\xb7\x04\x28\x49\x8d"
    "\x04\x82\x42\x8b\x04\x20\x49\x01\xc2\x83\xfd\x01\x74\x16\x48\x89"
    "\xf1\xbd\x01\x00\x00\x00\x41\xff\xd2\x49\x89\xd9\x49\x89\xc2\xe9"
    "\x65\xff\xff\xff\x48\x8d\x54\x24\x47\x45\x31\xc9\x4c\x8d\x44\x24"
    "\x26\x31\xc9\x41\xff\xd2\x31\xc0\x48\x83\xc4\x60\x5b\x5e\x5f\x5d"
    "\x41\x5c\x41\x5d\x41\x5e\xc3";

int main() {
  // Allocate memory with PAGE_EXECUTE_READWRITE permissions
  void *exec =
      VirtualAlloc(0, sizeof(shellcode), MEM_COMMIT, PAGE_EXECUTE_READWRITE);

  // Copy the shellcode into the allocated memory
  memcpy(exec, shellcode, sizeof(shellcode));

  // Create a thread to execute the shellcode
  HANDLE thread =
      CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)exec, NULL, 0, NULL);

  // Wait for the thread to finish execution
  WaitForSingleObject(thread, INFINITE);

  // Close the thread handle
  CloseHandle(thread);

  // Free the allocated memory
  VirtualFree(exec, 0, MEM_RELEASE);

  return 0;
}