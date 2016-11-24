#include "StdAfx.h"
#include ".\dicplug.h"
#include "resource.h"

CDicPlug::CDicPlug(void)
{
}

CDicPlug::~CDicPlug(void)
{
}

bool  CDicPlug::Initialize(ISetingUI* pSetingUI, 
                 ILogerUI* pLogerUI, ICommandUI* pCommandUI)
{
    // ������غ���г�ʼ��
    // ������������ʱ�����⿪��, �ɺ���֮
    return true;
}

void  CDicPlug::LanguageChange(const char * newLang, 
                     const char * oldLang)
{
    // �ı������ʹ�õ�����
}

const char * CDicPlug::GetPlugName(const char* Language)
{
    if(strcmp(Language, "LANG_CN") == 0) // ���Ĳ����
    {
        return "���ʵ������";
    }
    else // Ӣ��
    {
        return "Plug Sample Code";
    }
}

const char * CDicPlug::GetPlugSID()
{
    // �����ظ��Ĳ�� ID, ����ʹ�� GUID.
    return "F5789CE9-F75A-424b-B5FB-9051FFAD11EE";
}

MD5CRK_HWND  CDicPlug::CreatePlugWindow(MD5CRK_HWND  hWndParent,
                              int x, int y, int cx, int cy, const char* Language)
{
    extern HINSTANCE  g_hInstance;  // DllMain �б����

#pragma warning(disable : 4312 4311) // �ر�����ת������

    // �����������
    return (MD5CRK_HWND)CreateDialog(g_hInstance, 
        MAKEINTRESOURCE(IDD_SETDLG), (HWND)hWndParent, SetDlgProc);

#pragma warning(default : 4312 4311)
}

bool  CDicPlug::AnalyzeCommandLine(const char* cmdline)
{
    // ����������
    return true;
}

bool  CDicPlug::SaveSet(const unsigned char ** outbuf, int * len)
{
    // �������״̬
    strcpy((char *)*outbuf, "Hello World");
    *len = 12; // ���� \0
    return true;
}

bool  CDicPlug::ReadSet(const unsigned char * inbuf, int len)
{
    // ��ȡ����״̬

    // inbuf == "Hello World", len == 12
    return true;
}

bool  CDicPlug::SaveState(const unsigned char ** outbuf, int * len)
{
     // ������״̬
    return true;
}

bool  CDicPlug::ReadState(const unsigned char * inbuf, int len)
{
    // ��ȡ���״̬
    return true;
}

void  CDicPlug::ResetPlug(void)
{
    // ���ò��״̬
}

bool  CDicPlug::BeginOut(void)
{
    // ��ʼ�ƽ�
    return true;
}

int   CDicPlug::FillText(int count, int plain_maxlen,
               unsigned char* plain, int lengths[])
{
    for(int i = 0; i < count; ++i)
    {
        strcpy((char *)&plain[plain_maxlen * i], "plug sample");
        lengths[i] = 11; // ������ '\0'
    }

    return count;
}

void  CDicPlug::EndOut(void)
{
    // ֹͣ�ƽ�
}

const char * CDicPlug::GetPlugError(void)
{
    return "ERROR_SUCCEED";
}

BOOL APIENTRY CDicPlug::SetDlgProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch(message)
    {
    case WM_INITDIALOG:
        {
            return TRUE;
        }
        break;
    }
    return FALSE;
}
