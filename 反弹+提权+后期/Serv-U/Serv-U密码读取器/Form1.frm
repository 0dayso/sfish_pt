VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Serv-U���ع����ʺ������ȡ��"
   ClientHeight    =   2115
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3495
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2115
   ScaleWidth      =   3495
   StartUpPosition =   3  '����ȱʡ
   Begin VB.Frame Frame2 
      Caption         =   "AdminPWD"
      Height          =   615
      Left            =   240
      TabIndex        =   2
      Top             =   1200
      Width           =   3015
      Begin VB.TextBox Text2 
         Height          =   270
         Left            =   120
         TabIndex        =   3
         Top             =   240
         Width           =   2775
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "AdminName"
      Height          =   615
      Left            =   240
      TabIndex        =   0
      Top             =   480
      Width           =   3015
      Begin VB.TextBox Text1 
         Height          =   270
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   2775
      End
   End
   Begin VB.Label Label1 
      Caption         =   "�ڿͷ���ר��"
      BeginProperty Font 
         Name            =   "����"
         Size            =   10.5
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   1080
      TabIndex        =   4
      Top             =   120
      Width           =   1335
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim File1 As String   'servudaemon.exe ������·��
Dim servu(20)         '����һ�����������serv-u�Ĳ���
Dim suver As String
Dim vver              '�汾��־��ƫ�Ƶ�ַ(10����)
Dim suname            '�û���ƫ�Ƶ�ַ(10����)
Dim supwd             '����ƫ�Ƶ�ַ(10����)
Dim vstr As Byte
Dim ustr As Byte
Dim pstr As Byte
Dim vstr2 As String
Dim pstr2 As String   '���õ����û���
Dim ustr2 As String   '���õ�������
Private Sub Form_Load()
'��֧�ְ汾����Ϣ
servu(0) = "5.0.0.9:::2824881:::2992147:::2998464"
 '��֧�ְ汾����Ϣ
servu(1) = "5.2.0.1:::2856596:::2990235:::2997363"
'�õ�����Ŀ¼�ľ���·��
servu(2) = "5.0.0.11:::2847591:::3031144:::3037461"
Apppath = IIf(Right(App.Path, 1) = "\", Left(App.Path, Len(App.Path) - 1), App.Path)
'servudaemon.exe ��·��
File1 = Apppath & "\" & "ServUDaemon.exe"
'�ж�'servudaemon.exe�Ƿ����
If LCase(Dir(File1)) = "servudaemon.exe" Then
'���� servu ����
   For Each su In servu
      'Ϊssu��Ĵ�������,���suΪ�յĻ��ָ��ֵ��ssu�ǻ����
      If su = "" Then
       MsgBox "�������֧�ָð汾��Serv-U", , "���棡"
       Exit Sub
      End If
       '�ָ�su
        ssu = Split(su, ":::")
         '�Ѱ汾��־��ֵ��suver
        suver = ssu(0)
         '�汾��־��ƫ�Ƶ�ַ(10����)
        vver = Int(ssu(1))
       '�û���ƫ�Ƶ�ַ(10����)
        suname = Int(ssu(2))
       '����ƫ�Ƶ�ַ(10����)
        supwd = Int(ssu(3))
   
      '��2���Ʒ�ʽ��ServUDaemon.exe
      Open File1 For Binary As #2
           vstr2 = ""
         '��ȡ�汾��־
          For i = 1 To Len(suver)
              vver = vver + 1
              Get #2, "&H" & Hex(vver), vstr
        '��Ϊ��ȡ������ vstr ��һ��10���Ƶ�ascii,����Ҫ��chr��������ת���ַ�
              vstr2 = vstr2 & Chr(vstr)
          Next i
        
        '�жϰ汾��־�Ƿ���suver��ͬ,����ǾͶ�ȡ�ʺź�����
        If suver = vstr2 Then
              ustr2 = ""
              pstr2 = ""
          '��ȡ�ʺ�,һ��һ���ַ��Ķ�ȡ,Ȼ������Ǵ�����
          For i = 1 To 18
              suname = suname + 1
              Get #2, "&H" & Hex(suname), ustr
             '��Ϊ��ȡ������ ustr ��һ��10���Ƶ�ascii,����Ҫ��chr��������ת���ַ�
              ustr2 = ustr2 & Chr(ustr)
          Next i
        
         '��ȡ����,һ��һ���ַ��Ķ�ȡ,Ȼ������Ǵ�����
          For i = 1 To 14
              supwd = supwd + 1
              Get #2, "&H" & Hex(supwd), pstr
               '��Ϊ��ȡ������ pstr ��һ��10���Ƶ�ascii,����Ҫ��chr��������ת���ַ�
              pstr2 = pstr2 & Chr(pstr)
          Next
 
              Text1.Text = ustr2
              Text2.Text = pstr2
              Close #2
           Exit Sub
        End If
 
      Close #2
   Next
   
Else
        MsgBox "�Ҳ���ServUDaemon.exe�ļ�", , "���棡"
        Exit Sub
End If
End Sub

