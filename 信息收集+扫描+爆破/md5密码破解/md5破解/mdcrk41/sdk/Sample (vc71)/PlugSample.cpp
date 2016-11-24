// PlugSample.cpp : Defines the entry point for the DLL application.
//

#include "stdafx.h"
#include "DicPlug.h"  // ʵ�� MD5Crack �������

HINSTANCE  g_hInstance = NULL;

BOOL APIENTRY DllMain( HANDLE hModule, 
                       DWORD  ul_reason_for_call, 
                       LPVOID lpReserved
					 )
{
    if(ul_reason_for_call == DLL_PROCESS_ATTACH)
    {
        g_hInstance = (HINSTANCE)hModule;  // ����ģ�����������Ի���ʹ��
        //InitCommonControls();              // ��ʼ�� Windows �ؼ�
    }

    return TRUE;
}

// MD5Crack4 ����Ҫ�ĵ�������
extern "C" __declspec(dllexport)  IDicPlug*  GetPlugClass(void)
{
    static CDicPlug s_tdic;
    return static_cast<IDicPlug*>(&s_tdic);
}