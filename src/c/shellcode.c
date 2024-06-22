#include <stdio.h>
#include <windows.h>
#include <winnt.h>
#include <winternl.h>

static inline int cmpstr(char *a, char *b) {
  register size_t i = 0;
  while (a[i] != 0 && b[i] != 0 && a[i] == b[i]) {
    ++i;
  }
  return a[i] == 0 && b[i] == 0;
}


static inline PVOID getKernel32() {
  PPEB pPeb = (PPEB)__readgsqword(0x60);
  PPEB_LDR_DATA pLdrData = pPeb->Ldr;

  PLDR_DATA_TABLE_ENTRY pLdrEntry =
      (PLDR_DATA_TABLE_ENTRY)pLdrData->InMemoryOrderModuleList.Flink;
  pLdrEntry = *(void **)pLdrEntry;
  pLdrEntry = *(void **)pLdrEntry;
  pLdrEntry =
      CONTAINING_RECORD(pLdrEntry, LDR_DATA_TABLE_ENTRY, InMemoryOrderLinks);
  return pLdrEntry->DllBase;
}

__attribute__((always_inline)) static inline PVOID
FindFunction(PIMAGE_DOS_HEADER pDll, PCHAR FunctionName) {
  PVOID RVA = (PVOID)pDll + (ULONGLONG)pDll->e_lfanew;
  PIMAGE_NT_HEADERS pNtHeaders = (PIMAGE_NT_HEADERS)RVA;
  PIMAGE_OPTIONAL_HEADER pOptHeaders = &pNtHeaders->OptionalHeader;
  PIMAGE_DATA_DIRECTORY pDataDir =
      &pOptHeaders->DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT];
  PIMAGE_EXPORT_DIRECTORY pExportdir =
      (PIMAGE_EXPORT_DIRECTORY)((PBYTE)pDll + pDataDir->VirtualAddress);

  PDWORD ExportNamePT = (PDWORD)((PBYTE)pDll + pExportdir->AddressOfNames);
  PDWORD ExportAddrPT = (PDWORD)((PBYTE)pDll + pExportdir->AddressOfFunctions);
  PWORD ExportOrdnPT = (PWORD)((PBYTE)pDll + pExportdir->AddressOfNameOrdinals);

  for (size_t i = 0; i < pExportdir->NumberOfNames; ++i) {
    PCHAR name = (PCHAR)((PBYTE)pDll + ExportNamePT[i]);
    if (cmpstr(name, FunctionName)) {
      return (PVOID)(ExportAddrPT[ExportOrdnPT[i]] + (ULONGLONG)pDll);
    }
  }
  return NULL;
}

typedef PVOID(WINAPI *LoadLibraryH)(LPCSTR);
typedef int(WINAPI *MessageBoxH)(HWND, PCHAR, PCHAR, UINT);

int main() {
  CHAR FunNameLoadLib[] = "LoadLibraryA";
  CHAR FunNameMessageBox[] = "MessageBoxA";
  CHAR DllNameUser32[] = "user32.dll";
  CHAR Message[] = "HelloWorld!";
  CHAR Title[] = "Shellcode";
  LoadLibraryH LoadLibraryH = FindFunction(getKernel32(), FunNameLoadLib);
  PVOID pUser32Dll = LoadLibraryH(DllNameUser32);
  MessageBoxH MessageBoxH = FindFunction(pUser32Dll, FunNameMessageBox);
  MessageBoxH(NULL, Message, Title, 0);
  return 0;
}
// int main() {
//   CHAR FunNameLoadLib[] = "LoadLibraryA";
//   CHAR FunNameMessageBox[] = "MessageBoxA";
//   CHAR DllNameUser32[] = "user32.dll";
//   CHAR Message[] = "HelloWorld!";
//   CHAR Title[] = "Shellcode";
//
//   PVOID rip = NULL;
//   int i = 0;
//
//   PVOID pDll = NULL;
//   PCHAR FunctionName = NULL;
//   PVOID FunctionAddr = NULL;
//   LoadLibraryH LoadLibraryH = NULL;
//   MessageBoxH MessageBoxH = NULL;
//
//   pDll = getKernel32();
//   FunctionName = FunNameLoadLib;
//   goto LfindFunction;
// L0:
//   LoadLibraryH = FunctionAddr;
//   pDll = LoadLibraryH(DllNameUser32);
//   FunctionName = FunNameMessageBox;
//   goto LfindFunction;
// L1:
//   MessageBoxH = FunctionAddr;
//   MessageBoxH(NULL, Message, Title, 0);
//   return 0;
//
// LfindFunction:
//   FunctionAddr = FindFunction(pDll, FunctionName);
//   if (i == 0) {
//     ++i;
//     goto L0;
//   } else if (i == 1) {
//     goto L1;
//   }
// }
