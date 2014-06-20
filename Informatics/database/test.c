 #include  
 #include "c:\tc\valid.c"  
 #define MAX 25  

 enum e{ co=1,dsgt,hss }; 

 struct add  
 {  
	char addr[50];  
	char city[25];  
	char state[25];  
 };  

 struct stud  
 {  
	int roll,fds,dem;  
	int a;  
	char name[50];  
	struct add add1;

	union elective  
	{  
		int co,dsgt,hss;  
	}elec;  
 };  
 int withp(struct stud [],int);  
 struct stud* insertp();  
 int createp (struct stud *,int);  
 int searchp(struct stud *,int);  
 void editp(struct stud *,int);  
 void deletp(struct stud *,int);  
 void displayp(struct stud*);  
 int withoutp(struct stud [],int);  
 struct stud insert();  
 int create (struct stud [],int);  
 int search(struct stud [],int);  
 void edit(struct stud s1[],int n);  
 void delet(struct stud s1[],int n);  
 void display(struct stud s1);  
 int check(struct stud[],int,int);  
 void main()  
 {  
 int ch,n=0;  
 struct stud st[25];  
 do  
 {  
 clrscr();  
 printf("\n\n\n\t\t>>>>----  MANAGING DATABASE  ----<<<<\n");  
 printf("\n\t1\tWITH POINTERS\n");  
 printf("\t2\tWITHOUT POINTERS\n");  
 printf("\t3\tEXIT\n\n");  
 printf("\n\t\tENTER UR CHOICE\t");  
 ch=valid();  
 switch(ch)  
 {  
 case 1:     n=withp(st,n);  
 break;  
 case 2:  
 n=withoutp(st,n);  
 break;  
 case 3:  
 break;  
 default:  
 printf("\n\n!!!!  INVALID CHOICE  !!!!");  
 getch();  
 }  
 }  
 while(ch!=3);  
 }//end of main  
 /*********************************************************************  
 WITHP FUNCTION  
 **********************************************************************/  
 int withp(struct stud s1[],int n)  
 {  
 int ch,i,m;  
 struct stud *s;  
 void (*p) (struct stud*);  
 p=displayp;  
 do  
 {  
 clrscr();  
 printf("\n\n\t\t>>>>----  WITHOUT POINTER MENU  ----<<<<\n");  
 printf("\n\t1\tCREATE A NEW DATABASE");  
 printf("\n\t2\tINSERT");  
 printf("\n\t3\tDISPLAY");  
 printf("\n\t4\tEDIT");  
 printf("\n\t5\tSEARCH");  
 printf("\n\t6\tDELETE");  
 printf("\n\t7\tRETURN TO MAIN MENU \n");  
 printf("\n\t\tENTER UR CHOICE\t");  
 ch=valid();  
 switch(ch)  
 {  
 case 1:  
 n=createp(s1,MAX);  
 break;  
 case 2:  
 m=0;  
 do  
 {  
 if(m!=0)  
 {  
 printf("\n\n\tENTER AGAIN!!!!");  
 getch();  
 }  
 s=insertp();  
 s1[n]=*s;  
 m++;  
 }while(check(s1,s1[n].roll,n)==1);  
 n++;  
 break;  
 case 3:  
 if(n==0)  
 {  
 printf("\n\tFIRST CREATE DATABADE!!!");  
 getch();  
 break;  
 }  
 for(i=0;i<n;i++) <br=""> p(&s1[i]);  
 break;  
 case 4:  
 if(n==0)  
 {  
 printf("\n\tFIRST CREATE DATABASE!!!");  
 getch();  
 break;  
 }  
 editp(s1,n);  
 break;  
 case 5: if(n==0)  
 {  
 printf("\n\tFIRST CREATE DATABASE!!!");  
 getch();  
 break;  
 }  
 i=searchp(s1,n);  
 if(i>=0)  
 { printf("\n\tTHE RECORD IS PRESENT");  
 getch();  
 p(&s1[i]);  
 }  
 else  
 { printf("\n\t!! NOT FOUND !!");  
 getch();  
 }  
 break;  
 case 6:  
 if(n==0)  
 {  
 printf("\n\tFIRST CREATE DATABASE!!!");  
 getch();  
 break;  
 }  
 deletp(s1,n);  
 n--;  
 break;  
 case 7:  
 break;  
 default:  
 printf("\n\n\t\t!!!!   INVALID CHOICE  !!!!");  
 getch();  
 }//end of switch  
 }while(ch!=7);  
 return n;  
 }  
 /**********************************************************  
 DISPLAYP FUNCTION  
 ***********************************************************/  
 void displayp(struct stud *s1)  
 {  
 clrscr();  
 printf("\n\n\tROLL NO : %d",s1->roll);  
 printf("\n\tNAME : %s",s1->name);  
 printf("\n\tADDRESS:\n\t\t%s  ,\n\t\t%s  ,\n\t\t%s",s1->add1.addr,s1->add1.city,s1->add1.state);  
 printf("\n\tMARKS:-\n\tFDS\t%d\n\tDEM\t%d",s1->fds,s1->dem);  
 if(s1->a==co)  
 printf("\n\tCO\t%d",s1->elec.co);  
 else if(s1->a==dsgt)  
 printf("\n\tDSGT\t%d",s1->elec.dsgt);  
 else  
 printf("\n\tHSS\t%d",s1->elec.hss);  
 printf("\n\n\t!!! PRESS ANY KEY TO CONTINUE !!!!");  
 getch();  
 }  
 /*********************************************************  
 INSERTP FUNCTION  
 **********************************************************/  
 struct stud* insertp()  
 {  
 struct stud *s1;  
 int m;  
 clrscr();  
 printf("\n\t!!! --- !!!! \n\t ENTER DETAILS\n");  
 printf("\n>>>  ROLL NO->\t");  
 do  
 {  
 m=valid();  
 }while(m==-1);  
 s1->roll=m;  
 printf("\n>>>  NAME\t");  
 flushall();  
 scanf("%s",s1->name);  
 printf("\n>>>  ADDRESS \n\tSTREET NO-> / ROOM NO->\t");  
 flushall();  
 gets(s1->add1.addr);  
 printf("\n\tCITY\t");  
 flushall();  
 gets(s1->add1.city);  
 printf("\n\tSTATE\t");  
 flushall();  
 gets(s1->add1.state);  
 printf("\n>>>  MARKS IN ");  
 printf("\n\tF D S\t");  
 m=0;  
 do  
 {  
 if(m!=0 || m>100)  
 printf("\n\t ENTER AGAIN !!!!!\n");  
 m=valid();  
 }while(m==-1 || m>100);  
 s1->fds=m;  
 printf("\n\tDEM\t");  
 m=0;  
 do  
 {  
 if(m!=0 || m>100)  
 printf("\n\t ENTER AGAIN !!!!!\n");  
 m=valid();  
 }while(m==-1|| m>100);  
 s1->dem=m;  
 printf("\n\tSELECT ELECTIVE SUBJECT\t");  
 printf("\n\t1\tCO");  
 printf("\n\t2\tDSGT");  
 printf("\n\t3\tHSS");  
 printf("\n\n\tENTER UR CHOICE\t");  
 m=0;  
 do  
 {  
 if(m!=0 || m>3)  
 printf("\n\t ENTER AGAIN !!!!!\n");  
 m=valid();  
 }while(m==-1|| m>3);  
 s1->a=m;  
 if(s1->a==co)  
 {  
 printf("\n\tENTER MARKS IN CO\t ");  
 m=0;  
 do  
 {  
 if(m!=0 || m>100)  
 printf("\n\t ENTER AGAIN !!!!!\n");  
 m=valid();  
 }while(m==-1|| m>100);  
 s1->elec.co=m;  
 }  
 else if(s1->a==dsgt)  
 {  
 printf("\n\tENTER MARKS IN DSGT\t ");  
 m=0;  
 do  
 {  
 if(m!=0 || m>100)  
 printf("\n\t ENTER AGAIN !!!!!\n");  
 m=valid();  
 }while(m==-1|| m>100);  
 s1->elec.dsgt=m;  
 }  
 else  
 {  
 printf("\n\tENTER MARKS IN HSS\t");  
 m=0;  
 do  
 {  
 if(m!=0 || m>100)  
 printf("\n\t ENTER AGAIN !!!!!\n");  
 m=valid();  
 }while(m==-1 || m>100) ;  
 s1->elec.hss=m;  
 }  
 return s1;  
 }  
 /*****************************************************  
 CREATEP FUNCTION  
 *******************************************************/  
 int createp(struct stud *s1,int n)  
 {  
 int i=0;  
 do  
 {  
 *(s1+i)=insert();  
 i++;  
 printf("\n\t!!! DO U WANT TO INSERT MORE RECORDS (y \ n) !!!");  
 }while(getche() =='y'&& i<=n);  
 return i;  
 }  
 /**********************************************************  
 SEARCHP FUNCTION  
 ********************************************************/  
 int searchp(struct stud *s1,int n)  
 {  
 int i=0,rno;  
 printf("\n\tENTER ROLL NUMBER\t");  
 scanf("%d",&rno);  
 for(i=0;i<n;i++) <br=""> {  
 if((s1+i)->roll==rno)  
 return i;  
 }  
 return -1;  
 }  
 /*******************************************************  
 EDITP FUNCTION  
 ********************************************************/  
 void editp(struct stud s1[],int n)  
 {  
 int i;  
 i=search(s1,n);  
 if(i>=0)  
 {  
 int ch;  
 do  
 {  
 printf("\n\t\t\t\tMODIFY\n");  
 printf("\n\t\t\t1.ROLL\n\t\t\t2.NAME\n\t\t\t3.ADDRESS\n\t\t\t4.MARKS\n\t\t\t5.RETURN");  
 printf("\nEnter your choice: ");  
 scanf("%d",&ch);  
 switch(ch)  
 {  
 case 1:  
 printf("\nEnter new roll no: ");  
 scanf("%d",&s1[i].roll);  
 break;  
 case 2:  
 printf("\nEnter new name: ");  
 scanf("%s",&s1[i].name);  
 break;  
 case 3:  
 printf("\nEnter new address: ");  
 printf("\nHouse no. : ");  
 scanf("%d",&s1[i].add1.addr);  
 printf("\nCity: ");  
 scanf("%s",&s1[i].add1.city);  
 printf("\nState: ");  
 scanf("%s",&s1[i].add1.state);  
 break;  
 case 4:  
 printf("\nEnter new marks:");  
 printf("\nFDS: %d",s1[i].fds);  
 printf("\nDEM: %d",s1[i].dem);  
 if(s1[i].a==dsgt)  
 {  
 printf("\nDSGT: ");  
 scanf("%d",&s1[i].elec.dsgt);  
 }  
 if(s1[i].a==hss)  
 {  
 printf("\nHSS: ");  
 scanf("%d",&s1[i].elec.hss);  
 }  
 if(s1[i].a==co)  
 {  
 printf("\nCO: ");  
 scanf("%d",&s1[i].elec.co);  
 }  
 break;  
 case 5:  
 break;  
 default:printf("\n\nInvalid choice!!\n");  
 break;  
 }  
 }while(ch!=5);  
 printf("\n\n\tRECORD EDITED");  
 getch();  
 }  
 else  
 {  
 printf("\n\t\tRECORD NOT FOUND");  
 getch();  
 }  
 }  
 /*****************************************************  
 DELETP FUNCTION  
 *******************************************************/  
 void deletp(struct stud *s1,int n)  
 {  
 int i,j;  
 i=search(s1,n);  
 printf("\n\tdo u wanna delete\y(y\n)");  
 if(i>=0&&getche()=='y')  
 {  
 for(j=i+1;j<n;j++) <br=""> *(s1+j-1)=*(s1+j);  
 printf("\n\n\t!!!  DELETED !!!");  
 getch();  
 }  
 else  
 {  
 printf("\n\t\tnot deleted!!!!!!!!!");  
 getch();  
 }  
 }  
 /*********************************************************************  
 WITHOUTP FUNCTION  
 **********************************************************************/  
 int withoutp(struct stud s1[],int n)  
 {  
 int ch,i,m;  
 void (*p) (struct stud);  
 p=display;  
 do  
 {  
 clrscr();  
 printf("\n\n\t\t>>>>----  WITHOUT POINTER MENU  ----<<<<\n");  
 printf("\n\t1\tCREATE A NEW DATABASE");  
 printf("\n\t2\tINSERT");  
 printf("\n\t3\tDISPLAY");  
 printf("\n\t4\tEDIT");  
 printf("\n\t5\tSEARCH");  
 printf("\n\t6\tDELETE");  
 printf("\n\t7\tRETURN TO MAIN MENU \n");  
 printf("\n\t\tENTER UR CHOICE\t");  
 ch=valid();;  
 switch(ch)  
 {  
 case 1:  
 n=create(s1,MAX);  
 break;  
 case 2:  
 m=0;  
 do  
 {  
 if(m!=0)  
 {  
 printf("\n\n\tENTER AGAIN!!!!");  
 getch();  
 }  
 s1[n]=insert();  
 m++;  
 }while(check(s1,s1[n].roll,n)==1);  
 n++;  
 break;  
 case 3: if(n==0)  
 {  
 printf("\n\tFIRST CREATE DATABADE!!!");  
 getch();  
 break;  
 }  
 for(i=0;i<n;i++) <br=""> p(s1[i]);  
 break;  
 case 4:  
 if(n==0)  
 {  
 printf("\n\tFIRST CREATE DATABADE!!!");  
 getch();  
 break;  
 }  
 edit(s1,n);  
 break;  
 case 5:  
 if(n==0)  
 {  
 printf("\n\tFIRST CREATE DATABADE!!!");  
 getch();  
 break;  
 }  
 i=search(s1,n);  
 if(i>=0)  
 { printf("\n\tTHE RECORD IS PRESENT");  
 getch();  
 p(s1[i]);  
 }  
 else  
 { printf("\n\t!! NOT FOUND !!");  
 getch();  
 }  
 break;  
 case 6: if(n==0)  
 {  
 printf("\n\tFIRST CREATE DATABADE!!!");  
 getch();  
 break;  
 }  
 delet(s1,n);  
 n--;  
 break;  
 case 7:  
 break;  
 default:  
 printf("\n\n\t\t!!!!   INVALID CHOICE  !!!!");  
 getch();  
 }//end of switch  
 }while(ch!=7);  
 return n;  
 }  
 /**********************************************************  
 DISPLAY FUNCTION  
 ***********************************************************/  
 void display(struct stud s1)  
 {  
 clrscr();  
 printf("\n\n\tROLL NO : %d",s1.roll);  
 printf("\n\tNAME : %s",s1.name);  
 printf("\n\tADDRESS:\n\t\t%s  ,\n\t\t%s  ,\n\t\t%s",s1.add1.addr,s1.add1.city,s1.add1.state);  
 printf("\n\tMARKS:-\n\tFDS\t%d\n\tDEM\t%d",s1.fds,s1.dem);  
 if(s1.a==co)  
 printf("\n\tCO\t%d",s1.elec.co);  
 else if(s1.a==dsgt)  
 printf("\n\tDSGT\t%d",s1.elec.dsgt);  
 else  
 printf("\n\tHSS\t%d",s1.elec.hss);  
 printf("\n\n\t!!! PRESS ANY KEY TO CONTINUE !!!!");  
 getch();  
 }  
 /*********************************************************  
 INSERT FUNCTION  
 **********************************************************/  
 struct stud insert()  
 {  
 struct stud s1;  
 int m;  
 clrscr();  
 printf("\n\t!!! --- !!!! \n\t ENTER DETAILS\n");  
 printf("\n>>>  ROLL NO.\t");  
 m=0;  
 do  
 {  
 if(m!=0)  
 printf("\n\t ENTER AGAIN !!!!!\n");  
 m=valid();  
 }while(m==-1);  
 s1.roll=m;  
 printf("\n>>>  NAME\t");  
 flushall();  
 scanf("%s",s1.name);  
 printf("\n>>>  ADDRESS \n\tSTREET NO. / ROOM NO.\t");  
 flushall();  
 gets(s1.add1.addr);  
 printf("\n\tCITY\t");  
 flushall();  
 gets(s1.add1.city);  
 printf("\n\tSTATE\t");  
 flushall();  
 gets(s1.add1.state);  
 printf("\n>>>  MARKS IN ");  
 printf("\n\tF D S\t");  
 m=0;  
 do  
 {  
 if(m!=0 || m>100)  
 printf("\n\t ENTER AGAIN !!!!!\n");  
 m=valid();  
 }while(m==-1|| m>100);  
 s1.fds=m;  
 printf("\n\tDEM\t");  
 m=0;  
 do  
 {  
 if(m!=0 || m>100)  
 printf("\n\t ENTER AGAIN !!!!!\n");  
 m=valid();  
 }while(m==-1|| m>100);  
 s1.dem=m;  
 printf("\n\tSELECT ELECTIVE SUBJECT\t");  
 printf("\n\t1\tCO");  
 printf("\n\t2\tDSGT");  
 printf("\n\t3\tHSS");  
 printf("\n\n\tENTER UR CHOICE\t");  
 m=0;  
 do  
 {  
 if(m!=0 || m>3)  
 printf("\n\t ENTER AGAIN !!!!!\n");  
 m=valid();  
 }while(m==-1 || m>3);  
 s1.a=m;  
 if(s1.a==co)  
 {  
 printf("\n\tENTER MARKS IN CO\t ");  
 m=0;  
 do  
 {  
 if(m!=0 || m>100)  
 printf("\n\t ENTER AGAIN !!!!!\n");  
 m=valid();  
 }while(m==-1 || m>100);  
 s1.elec.co=m;  
 }  
 else if(s1.a==dsgt)  
 {  
 printf("\n\tENTER MARKS IN DSGT\t ");  
 m=0;  
 do  
 {  
 if(m!=0 || m>100)  
 printf("\n\t ENTER AGAIN !!!!!\n");  
 m=valid();  
 }while(m==-1 || m>100);  
 s1.elec.dsgt=m;  
 }  
 else  
 {  
 printf("\n\tENTER MARKS IN HSS\t");  
 m=0;  
 do  
 {  
 if(m!=0 || m>100)  
 printf("\n\t ENTER AGAIN !!!!!\n");  
 m=valid();  
 }while(m==-1 || m>100);  
 s1.elec.hss=m;  
 }  
 return s1;  
 }  
 /*****************************************************  
 CREATE FUNCTION  
 *******************************************************/  
 int create(struct stud s1[25],int n)  
 {  
 int i=0;  
 do  
 {  
 s1[i]=insert();  
 i++;  
 printf("\n\t!!! DO U WANT TO INSERT MORE RECORDS (y \ n) !!!");  
 }while(getche()=='y'&& i<=n);  
 return i;  
 }  
 /**********************************************************  
 SEARCH FUNCTION  
 ********************************************************/  
 int search(struct stud s1[],int n)  
 {  
 int i,rno;  
 printf("\n\tENTER ROLL NUMBER\t");  
 scanf("%d",&rno);  
 for(i=0;i<n;i++) <br=""> {  
 if(s1[i].roll==rno)  
 return i;  
 }  
 return -1;  
 }  
 /*******************************************************  
 EDIT FUNCTION  
 ********************************************************/  
 void edit(struct stud s1[],int n)  
 {  
 int i;  
 i=search(s1,n);  
 if(i>=0)  
 {  
 int ch;  
 do  
 {  
 printf("\n\t\t\t\tMODIFY\n");  
 printf("\n\t\t\t1.ROLL\n\t\t\t2.NAME\n\t\t\t3.ADDRESS\n\t\t\t4.MARKS\n\t\t\t5.RETURN");  
 printf("\nEnter your choice: ");  
 scanf("%d",&ch);  
 switch(ch)  
 {  
 case 1:  
 printf("\nEnter new roll no: ");  
 scanf("%d",&s1[i].roll);  
 break;  
 case 2:  
 printf("\nEnter new name: ");  
 scanf("%s",&s1[i].name);  
 break;  
 case 3:  
 printf("\nEnter new address: ");  
 printf("\nHouse no. : ");  
 scanf("%d",&s1[i].add1.addr);  
 printf("\nCity: ");  
 scanf("%s",&s1[i].add1.city);  
 printf("\nState: ");  
 scanf("%s",&s1[i].add1.state);  
 break;  
 case 4:  
 printf("\nEnter new marks:");  
 printf("\nFDS: %d",s1[i].fds);  
 printf("\nDEM: %d",s1[i].dem);  
 if(s1[i].a==dsgt)  
 {  
 printf("\nDSGT: ");  
 scanf("%d",&s1[i].elec.dsgt);  
 }  
 if(s1[i].a==hss)  
 {  
 printf("\nHSS: ");  
 scanf("%d",&s1[i].elec.hss);  
 }  
 if(s1[i].a==co)  
 {  
 printf("\nCO: ");  
 scanf("%d",&s1[i].elec.co);  
 }  
 break;  
 case 5:  
 break;  
 default:printf("\n\nInvalid choice!!\n");  
 break;  
 }  
 }while(ch!=5);  
 printf("\n\n\tRECORD EDITED");  
 getch();  
 }  
 else  
 {  
 printf("\n\t\tRECORD NOT FOUND");  
 getch();  
 }  
 }  
 /*****************************************************  
 DELET FUNCTION  
 *******************************************************/  
 void delet(struct stud s1[],int n)  
 {  
 int i,j;  
 i=search(s1,n);  
 printf("\n\tdo u wanna delete\y(y\n)");  
 if(i>=0&&getche()=='y')  
 {  
 for(j=i+1;j<n;j++) <br=""> s1[j-1]=s1[j];  
 printf("\n\n\t!!!  DELETED !!!");  
 getch();  
 }  
 else  
 {  
 printf("\n\t\tRECORD NOT Deleted");  
 getch();  
 }  
 }  
 int check(struct stud e[],int rno, int n)  
 {  
 int i;  
 for(i=0;i<n;i++) <br=""> if(e[i].roll==rno)  
 return 1;  
 return 0;  
 }
