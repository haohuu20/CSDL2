/*
-- ten table space
select tablespace_name from dba_tablespaces;

-- tên datafile
select name from v$datafile;

-- kiểm tra kích thước
select bytes/1024/1024 MB, name from v$datafile;

-- tạo tablespace
create tablespace testtablespace1
    datafile'C:\APP\ADMIN\ORADATA\ORCL\testtablespace1.DBF'size 200m
    AUTOEXTEND ON NEXT 200m MAXSIZE 1024M
    EXTENT MANAGEMENT LOCAL;
-- thong tin tablespace
desc dba_tablespaces;
*/



create table giaovien(
magv varchar2(10) primary key,
tengv nvarchar2(50),
diachi nvarchar2(50),
sodt varchar2(15),
ngaysinh date
);

create table cahoc(
maca varchar2(10) primary key,
tenca nvarchar2(20)
);

create table phonghoc(
sophong varchar2(15) primary key
);

create table khoahoc(
makh varchar2(10) primary key,
tenkh nvarchar2(50),
nienkhoa varchar2(15)
);

create table lophoc(
malh varchar2(10) primary key,
tenlh nvarchar2(50),
ngaybatdau date,
ngayketthuc date,
makh varchar2(10),
constraint lhfk1 foreign key (makh) references khoahoc(makh)
);

create table bangphancong(
malh varchar2(10),
constraint bpcfk1 foreign key (malh) references lophoc(malh),
sophong varchar2(15),
constraint bpcfk2 foreign key (sophong) references phonghoc(sophong),
maca varchar2(10),
constraint bpcfk3 foreign key (maca) references cahoc(maca),
magv varchar2(10),
constraint bpcfk4 foreign key (magv) references giaovien(magv),
thu nvarchar2(50)
);


create table hocvien(
mahv varchar2(10) primary key,
tenhv nvarchar2(50),
ngaysinh date,
diachi nvarchar2(50),
sodt varchar2(15),
malh varchar2(10),
constraint hvfk1 foreign key (malh) references lophoc(malh)
);

create table chungchi(
socc varchar2(10) primary key,
tencc nvarchar2(30),
diem number,
mahv varchar2(10),
constraint ccfk1 foreign key (mahv) references hocvien(mahv)
);

create table dangky(
makh varchar2(10),
constraint dkfk1 foreign key (makh) references khoahoc(makh),
mahv varchar2(10),
constraint dkfk2 foreign key (mahv) references hocvien(mahv),
ngaydk date
);
alter table dangky
add constraint pk_dk primary key (makh, mahv);

create table bienlai(
mabl varchar2(10) primary key,
makh varchar2(10),
constraint blfk1 foreign key (makh) references khoahoc(makh),
mahv varchar2(10),
constraint blfk2 foreign key (mahv) references hocvien(mahv),
ngaythu date,
sotien float
);

alter table dangky
add constraint pk_dk primary key (makh, mahv);

alter table bangphancong
add constraint pk_bpc primary key (malh, sophong, maca,magv);
----Nhap du lieu
INSERT INTO giaovien VALUES ('GV01','Nguyen Thi Lan Phuong','Ha Noi','0868235966',to_date('23/04/1992','dd/mm/yy'));
INSERT INTO giaovien VALUES ('GV02','Le Hoang Long','Vinh Phuc','0963233458',to_date('23/06/1994','dd/mm/yy'));
INSERT INTO giaovien VALUES ('GV03','Nguyen Kim Dung','','0898938222',to_date('8/06/1994','dd/mm/yy'));
INSERT INTO giaovien VALUES ('GV04','Tran Thi Hang','Thai Binh','',to_date('','dd/mm/yy'));
INSERT INTO giaovien VALUES ('GV05','Pham Lan Phuong','Tuyen Quang','0376648888',to_date('23/8/1990','dd/mm/yy'));
INSERT INTO giaovien VALUES ('GV06','Tran Thu Thuy','Thai Nguyen','0885989999',to_date('2/06/1996','dd/mm/yy'));
INSERT INTO giaovien VALUES ('GV07','Nguyen Lan Anh','Hà Noi','0886013333',to_date('3/05/1997','dd/mm/yy'));

INSERT INTO cahoc VALUES ('C1','Ca 1');
INSERT INTO cahoc VALUES ('C2','Ca 2');
INSERT INTO cahoc VALUES ('C3','Ca 3');
INSERT INTO cahoc VALUES ('C4','Ca 4');
INSERT INTO cahoc VALUES ('C5','Ca 5');

INSERT INTO phonghoc VALUES ('P101');
INSERT INTO phonghoc VALUES ('P102');
INSERT INTO phonghoc VALUES ('P201');
INSERT INTO phonghoc VALUES ('P202');
INSERT INTO phonghoc VALUES ('P301');
INSERT INTO phonghoc VALUES ('P302');
INSERT INTO phonghoc VALUES ('P401');

INSERT INTO khoahoc VALUES ('ENGI01','Ielts 600','	2021');
INSERT INTO khoahoc VALUES ('ENGI02','Ielts 600+','2022');
INSERT INTO khoahoc VALUES ('ENGT01','Toeic 650','2021');
INSERT INTO khoahoc VALUES ('ENGT02','Toeic 650+', '2022');
INSERT INTO khoahoc VALUES ('ENGCB01','Tieng Anh can ban','	2021');
INSERT INTO khoahoc VALUES ('ENGCB02','	Tieng Anh can ban','2022');

INSERT INTO lophoc VALUES ('H01','Ielts 600',to_date('01/01/2021','dd/mm/yy'),to_date('31/12/2021','dd/mm/yy'),'ENGI01');
INSERT INTO lophoc VALUES ('H02','Ielts 600+',to_date('01/02/2021','dd/mm/yy'),to_date('31/1/2022','dd/mm/yy'),'ENGI02');
INSERT INTO lophoc VALUES ('H03','Ielts 600+',to_date('01/03/2021','dd/mm/yy'),to_date('25/2/2022','dd/mm/yy'),'ENGI02');
INSERT INTO lophoc VALUES ('H04','Toeic 650',to_date('01/01/2021','dd/mm/yy'),to_date('01/06/2021','dd/mm/yy'),'ENGT01');
INSERT INTO lophoc VALUES ('H05','Toeic 650+',to_date('05/01/2021','dd/mm/yy'),to_date('05/01/2022','dd/mm/yy'),'ENGT02');
INSERT INTO lophoc VALUES ('H06','Tieng Anh can ban 1',to_date('10/01/2021','dd/mm/yy'),to_date('01/07/2021','dd/mm/yy'),'ENGCB01');
INSERT INTO lophoc VALUES ('H07','Tieng Anh can ban 2',to_date('28/07/2021','dd/mm/yy'),to_date('01/08/2022','dd/mm/yy'),'ENGCB02');


INSERT INTO bangphancong VALUES ('H01','P101','C1','GV07','Thu 2 va Thu 5');
INSERT INTO bangphancong VALUES ('H02','P301','C3','GV05','Thu 2 va Thu 5');
INSERT INTO bangphancong VALUES ('H03','P202','C4','GV02','Thu 3 va Thu 6');
INSERT INTO bangphancong VALUES ('H04','P102','C2','GV01','Thu 3 va Thu 6');
INSERT INTO bangphancong VALUES ('H05','P201','C5','GV03','Thu 3 va Thu 6');
INSERT INTO bangphancong VALUES ('H06','P302','C2','GV06','Thu 4 va Thu 7');
INSERT INTO bangphancong VALUES ('H07','P401','C3','GV04','Thu 4 va Thu 7');

INSERT INTO hocvien VALUES ('HV01','Nguyen Ngoc Han',to_date('02/03/2001','dd/mm/yy'),'Ha Noi','0979012222','H07');
INSERT INTO hocvien VALUES ('HV02','Pham Tan Minh',to_date('16/05/2002','dd/mm/yy'),'Nghe An','0898868865','H01');
INSERT INTO hocvien VALUES ('HV03','Phan Khac Tan',to_date('05/07/2001','dd/mm/yy'),'','0983337887','H02');
INSERT INTO hocvien VALUES ('HV04','Mai Thi Linh',to_date('24/08/2002','dd/mm/yy'),'Ha Nam','','H04');
INSERT INTO hocvien VALUES ('HV05','Nguyen Thi Thuy',to_date('14/03/2001','dd/mm/yy'),'Tuyen Quang','0889899494','H05');
INSERT INTO hocvien VALUES ('HV06','Tran Huy An',to_date('12/06/2000','dd/mm/yy'),'Ha Noi','0908332288','H06');
INSERT INTO hocvien VALUES ('HV07','Tran Mai Linh',to_date('18/04/2002','dd/mm/yy'),'Son La','','H03');
INSERT INTO hocvien VALUES ('HV08','Tran Thu Hang',to_date('08/03/2000','dd/mm/yy'),'','0802305999','H01');
INSERT INTO hocvien VALUES ('HV09','Nguyen Van Long',to_date('18/09/2001','dd/mm/yy'),'','0898998999','H04');
INSERT INTO hocvien VALUES ('HV10','Tran Hoang Anh',to_date('27/05/2000','dd/mm/yy'),'Nam Dinh','0884111616','H03');
INSERT INTO hocvien VALUES ('HV11','Tran Thao Linh',to_date('08/03/2001','dd/mm/yy'),'Hung Yen','0912637483','H03');
INSERT INTO hocvien VALUES ('HV12','Pham Viet Long',to_date('11/11/1997','dd/mm/yy'),'Ha Noi','0836274622','H01');
INSERT INTO hocvien VALUES ('HV13','Phan Quang Huy',to_date('7/6/1990','dd/mm/yy'),'Bac Giang','0937462832','H04');
INSERT INTO hocvien VALUES ('HV14','Phan Van Quang',to_date('30/6/2002','dd/mm/yy'),'Thanh Hoa','0855372842','H03');
INSERT INTO hocvien VALUES ('HV15','Vu Van Phan',to_date('27/12/2000','dd/mm/yy'),'Vinh Phuc','0927354623','H04');
INSERT INTO hocvien VALUES ('HV16','Tran Thu An',to_date('4/3/2001','dd/mm/yy'),'Bac Ninh','0947254728','H05');
INSERT INTO hocvien VALUES ('HV17','Tran Tien Dung',to_date('22/10/2000','dd/mm/yy'),'Thai Nguyen','0836472531','H06');
INSERT INTO hocvien VALUES ('HV18','Tran Thanh Tam',to_date('29/5/2000','dd/mm/yy'),'Ha Nam','0936452716','H07');
INSERT INTO hocvien VALUES ('HV19','Nguyen Bao Quyen',to_date('27/11/2001','dd/mm/yy'),'Thai Binh','0937462742','H01');
INSERT INTO hocvien VALUES ('HV20','Nguyen Trang Anh',to_date('27/9/2000','dd/mm/yy'),'Nam Dinh','0932674537','H02');

INSERT INTO chungchi VALUES ('0093254','Ielts',650,'HV03');
INSERT INTO chungchi VALUES ('0083471','Toeic',650,'HV05');
INSERT INTO chungchi VALUES ('0037194','Ielts',550,'HV08');
INSERT INTO chungchi VALUES ('0036179','Ielts',500,'HV10');
INSERT INTO chungchi VALUES ('0093723','Toeic',550,'HV09');
INSERT INTO chungchi VALUES ('0083274','Toeic',650,'HV04');

INSERT INTO dangky VALUES ('ENGCB02','HV01',to_date('12/12/2020','dd/mm/yy'));
INSERT INTO dangky VALUES ('ENGI01','HV02',to_date('24/12/2020','dd/mm/yy'));
INSERT INTO dangky VALUES ('ENGI02','HV03','');
INSERT INTO dangky VALUES ('ENGT01','HV04',to_date('20/12/2020','dd/mm/yy'));
INSERT INTO dangky VALUES ('ENGT02','HV05',to_date('10/11/2020','dd/mm/yy'));
INSERT INTO dangky VALUES ('ENGCB01','HV06',to_date('13/06/2020','dd/mm/yy'));
INSERT INTO dangky VALUES ('ENGT01','HV07',to_date('13/10/2020','dd/mm/yy'));
INSERT INTO dangky VALUES ('ENGI01','HV08',to_date('21/12/2020','dd/mm/yy'));
INSERT INTO dangky VALUES ('ENGT01','HV09',to_date('23/06/2020','dd/mm/yy'));
INSERT INTO dangky VALUES ('ENGI02','HV10',to_date('28/03/2020','dd/mm/yy'));
INSERT INTO dangky VALUES ('ENGI02','HV11',to_date('12/06/2020','dd/mm/yy'));
INSERT INTO dangky VALUES ('ENGI01','HV12',to_date('12/10/2020','dd/mm/yy'));
INSERT INTO dangky VALUES ('ENGT01','HV13',to_date('22/06/2020','dd/mm/yy'));
INSERT INTO dangky VALUES ('ENGI02','HV14',to_date('27/03/2020','dd/mm/yy'));
INSERT INTO dangky VALUES ('ENGT01','HV15',to_date('19/12/2020','dd/mm/yy'));
INSERT INTO dangky VALUES ('ENGT02','HV16',to_date('09/11/2020','dd/mm/yy'));
INSERT INTO dangky VALUES ('ENGCB01','HV17',to_date('10/12/2020','dd/mm/yy'));
INSERT INTO dangky VALUES ('ENGCB02','HV18',to_date('11/12/2020','dd/mm/yy'));
INSERT INTO dangky VALUES ('ENGI01','HV19',to_date('23/12/2020','dd/mm/yy'));
INSERT INTO dangky VALUES ('ENGI02','HV20',to_date('14/12/2020','dd/mm/yy'));

INSERT INTO bienlai VALUES ('B01','ENGCB02','HV01',to_date('28/07/2021','dd/mm/yy'),3000000);
INSERT INTO bienlai VALUES ('B02','ENGI01','HV02',to_date('01/01/2021','dd/mm/yy'),15000000);
INSERT INTO bienlai VALUES ('B03','ENGI02','HV03',to_date('01/02/2021','dd/mm/yy'),15500000);
INSERT INTO bienlai VALUES ('B04','ENGT01','HV04',to_date('01/01/2021','dd/mm/yy'),8000000);
INSERT INTO bienlai VALUES ('B05','ENGT02','HV05',to_date('05/01/2021','dd/mm/yy'),8500000);
INSERT INTO bienlai VALUES ('B06','ENGCB01','HV06',to_date('10/01/2021','dd/mm/yy'),3000000);
INSERT INTO bienlai VALUES ('B07','ENGI02','HV07',to_date('01/02/2021','dd/mm/yy'),15500000);
INSERT INTO bienlai VALUES ('B08','ENGI01','HV08',to_date('01/01/2021','dd/mm/yy'),15000000);
INSERT INTO bienlai VALUES ('B09','ENGT01','HV09',to_date('01/01/2021','dd/mm/yy'),8000000);
INSERT INTO bienlai VALUES ('B10','ENGI02','HV10',to_date('01/02/2021','dd/mm/yy'),15500000);
INSERT INTO bienlai VALUES ('B11','ENGI02','HV11',to_date('01/02/2021','dd/mm/yy'),15500000);
INSERT INTO bienlai VALUES ('B12','ENGI01','HV12',to_date('01/01/2021','dd/mm/yy'),15000000);
INSERT INTO bienlai VALUES ('B13','ENGT01','HV13',to_date('01/01/2021','dd/mm/yy'),8000000);
INSERT INTO bienlai VALUES ('B14','ENGI02','HV14',to_date('01/02/2021','dd/mm/yy'),15500000);
INSERT INTO bienlai VALUES ('B15','ENGT01','HV15',to_date('01/01/2021','dd/mm/yy'),8000000);
INSERT INTO bienlai VALUES ('B16','ENGT02','HV16',to_date('05/01/2021','dd/mm/yy'),8500000);
INSERT INTO bienlai VALUES ('B17','ENGCB01','HV17',to_date('10/01/2021','dd/mm/yy'),3000000);
INSERT INTO bienlai VALUES ('B18','ENGCB02','HV18',to_date('28/07/2021','dd/mm/yy'),3000000);
INSERT INTO bienlai VALUES ('B19','ENGI01','HV19',to_date('01/01/2021','dd/mm/yy'),15000000);
INSERT INTO bienlai VALUES ('B20','ENGI02','HV20',to_date('01/02/2021','dd/mm/yy'),15500000);


---
select * from giaovien;
select * from cahoc;
select * from phonghoc;
select * from lophoc;
select * from bangphancong;
select * from khoahoc;
select * from hocvien;
select * from chungchi;
select * from dangky;
select * from bienlai order by sotien asc;

/*
-- ngay thu phai sau ngay dang ky
create or replace trigger trg1
before 
insert or update
on bienlai
for each row
declare
 ngay dangky.ngaydk%type;
begin
 select ngaydk
 into ngay
 from dangky
 where :new.makh = makh and :new.mahv = mahv;
 if :new.ngaythu < ngay then
   raise_application_error(-20010,'Ngay thu tien phai sau ngay dang ky!');
 end if;
end;

-- thu trigger
update bienlai
set ngaythu = to_date('28/07/2011','dd/mm/yy')
where mabl = 'B01'
*/


/*
--Truy van

--c1: lay ra danh sach hoc vien sap xep theo tuoi tang dan
select * from hocvien order by ngaysinh desc

--c2: danh sach hoc vien que o Ha Noi
select * from hocvien where diachi = 'Ha Noi'

--c3: do tuoi trung binh cua hoc vien la bao nhieu
select avg(current_date - ngaysinh)/365 as "Tuoi trung binh" from hocvien

--c4: nhung hoc vien co cung dia chi
select distinct hv1.tenhv, hv1.diachi from hocvien hv1, hocvien hv2 
where hv1.mahv != hv2.mahv and hv1.diachi = hv2.diachi order by hv1.diachi asc

--c5: danh sach hoc vien cua lop co ma lop la ENGI02
select * from hocvien join lophoc using(malh) where makh = 'ENGI02'

--c6: nhung hoc vien nao co chung chi Ielts
select * from hocvien join chungchi using(mahv) where tencc = 'Ielts'

--c7: thong tin ten giao vien, ten lop, so phong hoc vao ca 1
select tengv, tenlh, sophong from (((giaovien join bangphancong using(magv)) join phonghoc using(sophong)) join cahoc
 using(maca)) join lophoc using(malh) where tenca = 'Ca 1'





--C1: thông tin các học viên đạt chứng chỉ.
	Select hocvien.mahv, hocvien.tenhv, hocvien.ngaysinh, hocvien.sodt, hocvien.diachi
from hocvien inner join chungchi
on chungchi.mahv = hocvien.mahv
--C2: nhập vào mã học viên cho biết số tiền mà học viên đó phải đóng
set serveroutput on
accept ma prompt 'Nhap ma hoc vien:'
declare
    ma hocvien.mahv%type;
    cursor ds is select * from bienlai where mahv = ma;
begin
    ma := '&ma';
    for i in ds
    loop
    dbms_output.put_line('hoc vien "'||i.mahv||'" dong so tien la:  '|| i.sotien);
    end loop;
end;

--C3: trung tâm có tất cả bao nhiêu khóa học
Select count(makh) from khoahoc

--C4: Cho biết số lượng học viên của mỗi lớp
Select lophoc.malh, lophoc.tenlh, count(hocvien.mahv) as soluonghocvien
From hocvien join lophoc on hocvien.malh = lophoc.malh
Group by lophoc.malh, lophoc.tenlh


--c9: dem so hoc vien dang ki lop ENGT01 sau ngay 23/5/2020
select count(*)as "so luong hoc vien" from hocvien inner join dangky on (hocvien.mahv = dangky.mahv)
where dangky.makh ='ENGT01' and dangky.ngaydk > '23/May/2020' 


--tìm 3 học viên đăng kí cuối cùng của năm 2020
select * from (select * from hocvien join dangky using(mahv) 
where (ngaydk is not null) and (extract(year from ngaydk) = 2020) order by ngaydk desc) where rownum < 4

--tìm những học viên ghi thiếu số điện thoại hoặc địa chỉ
select * from hocvien where sodt is null or diachi is null

select * from giaovien;
select * from cahoc;
select * from phonghoc;
select * from lophoc;
select * from bangphancong;
select * from khoahoc;
select * from hocvien;
select * from chungchi;
select * from dangky order by ngaydk desc

select * from bienlai order by sotien asc;


----Cau 1: Cho biet hoc vien co diem Ielts >500;
select mahv,tenhv,diem from hocvien join chungchi using(mahv) where tencc='Ielts' and diem>500 ;
----------------------------------------------------------------------
--- Cau 2: Thong ke nhung hoc vien sinh nam 2001
select * from hocvien where extract (year from ngaysinh)=2001;
-----------------------------------------------------------------------
--- Cau3: Cho biet so luong hoc vien cua moi khoa hoc
select khoahoc.makh,khoahoc.tenkh, count(mahv) as "so luong" from ((khoahoc inner join lophoc on khoahoc.makh=lophoc.makh)
inner join hocvien on lophoc.malh=hocvien.malh) group by khoahoc.makh,khoahoc.tenkh;
---------------------------------------------------
---Cau 4:Danh sach nhung hoc vien khong co chung chi--
select hocvien.mahv,hocvien.tenhv from hocvien where not exists (select mahv from chungchi where hocvien.mahv = chungchi.mahv );
-------------------------------------------------------
--cau 5 :viet ham tra nhap vao ma lop cho biet lop qua han, con han 
create or replace function hanlop
  (malop in lophoc.malh%type)
return nvarchar2
as
    han number;
    han2 number;
begin
    select sysdate - ngayketthuc, sysdate - ngaybatdau
    into han, han2
    from lophoc 
    where malh=malop;
    if han > 0 then 
         return 'Da hoc xong';
    elsif han < 0 and han2 >= 0 then 
         return 'Dang hoc';
    elsif han < 0 and han2 < 0 then 
         return 'Lop chua mơ';
    elsif han = 0 then
         return 'Hom nay la buoi cuoi';
    end if;
    exception
    when no_data_found then
         return ' Khong co ma lop "'||malop||'"!';
end;
---thuc thi
set serveroutput on
accept malop prompt 'Nhap ma lop học:'
declare 
    malop lophoc.malh%type;
begin
    malop:='&malop';
    dbms_output.put_line( hanlop(malop));
end;
---------------------------------------------------
---cau6: dua danh sach hoc vien hoc lop " Tieng anh can ban 1"
set serveroutput on
declare
    cursor dshv is ( select hocvien.mahv,hocvien.tenhv, hocvien.diachi,hocvien.sodt from hocvien,lophoc where hocvien.malh=lophoc.malh and lophoc.tenlh='Tieng Anh can ban 1');
begin
    for i in dshv
    loop
    dbms_output.put_line(' danh sach hoc vien hoc lop " Tieng anh can ban 1" la: ma hoc vien'||i.mahv || ' ten hoc vien '|| i.tenhv || ' Dia chi: '||i.diachi ||' SDT: ' ||i.sodt);
    end loop;
end;
----------------------------------------------------------
---cau7: Nhap vao ten chung chi  cho biet ten hoc vien va diem cua hoc vien do
create or replace procedure nhapcc( tenchungchi chungchi.tencc%type)
as
    cursor cc is (select mahv, tenhv,diem from chungchi join hocvien using (mahv) where tencc=tenchungchi);
    gan cc%rowtype;
    kt exception;
begin
    open cc;
    loop 
    fetch cc into gan;
    exit when cc%notfound;
       dbms_output.put_line(' Hoc vien co ma hoc vien la'||gan.mahv||' ten la: '||gan.tenhv || ' Diem la: '||gan.diem);
    end loop;
    if gan.mahv is null then
        raise kt;
    end if;
    exception
    when kt then
       dbms_output.put_line('Khong co chung chi nao ten la: '||tenchungchi);
    close cc;
end;
--thuc thi---
set serveroutput on
accept tenchungchi prompt 'Nhap ten chung chi:'
declare
    tenchungchi chungchi.tencc%type;
begin
    tenchungchi:='&tenchungchi';
    nhapcc(tenchungchi);
end;


--Nhập vào tên giáo viên,cho biết giáo viên đó dạy lớp nào,ca mấy và phòng bao nhiêu?
create or replace procedure ttgv(
ten giaovien.tengv%type)
as
  cursor ds is select tengv, tenlh, sophong, tenca from (((giaovien join bangphancong using(magv)) join phonghoc using(sophong)) 
                                                      join cahoc using(maca)) join lophoc using(malh) where tengv = ten;
   gan ds%rowtype;
   kt exception;
begin
  open ds;
  loop
  fetch ds into gan;
  exit when ds%notfound;
     dbms_output.put_line('Giao vien '||gan.tengv||' day lop '||gan.tenlh||' vao '||gan.tenca||' tai phong '||gan.sophong);
  end loop;
  if gan.tengv is null then
    raise kt;
  end if;
  exception
  when kt then
     dbms_output.put_line('Khong co ten giao vien: '||ten);
  close ds;
end;

-- chay
set serveroutput on
accept ten prompt 'Nhap ten giao vien:'
declare 
   ten giaovien.tengv%type;
begin
   ten := '&ten';
   ttgv(ten);
end;
*/


-----------------------------------------------------------------
--10 yeu cau truy van
--c1: lay ra danh sach thong tin hoc vien sap xep theo tuoi tang dan
select *  from hocvien order by ngaysinh desc

--c2: Cho biet so luong hoc vien cua moi khoa hoc
select khoahoc.makh,khoahoc.tenkh, count(mahv) as "so luong" from ((khoahoc inner join lophoc on khoahoc.makh=lophoc.makh)
inner join hocvien on lophoc.malh=hocvien.malh) group by khoahoc.makh,khoahoc.tenkh;

--c3: do tuoi trung binh cua hoc vien la bao nhieu
select avg(current_date - ngaysinh)/365 as "Tuoi trung binh" from hocvien

--c4: nhung hoc vien co cung dia chi
select distinct hv1.tenhv, hv1.diachi from hocvien hv1, hocvien hv2 
where hv1.mahv != hv2.mahv and hv1.diachi = hv2.diachi order by hv1.diachi asc

--c5: danh sach hoc vien cua lop co ma lop la ENGI02
select tenhv from hocvien join lophoc using(malh) where makh = 'ENGI02'

--c6: nhung hoc vien nao co chung chi Ielts
select tenhv from hocvien join chungchi using(mahv) where tencc = 'Ielts'

--c7: thong tin ten giao vien, ten lop, so phong hoc vao ca 1
select tengv, tenlh, sophong from (((giaovien join bangphancong using(magv)) join phonghoc using(sophong)) join cahoc
 using(maca)) join lophoc using(malh) where tenca = 'Ca 1'
 
--c8:Thong tin ten hoc vien,ten chung chi,diem cua nhung hoc vien dat chung chi
Select tenhv,tencc,diem from hocvien join chungchi using (mahv);
 
--c9:Nhung hoc vien co diem Toeic tren 600
select tenhv from hocvien join chungchi using(mahv) where tencc='Toeic' and diem>600;
 
--c10:Dua ra danh sach nhung hoc vien khong dat chung chi
select tenhv from hocvien where not exists(select mahv from chungchi where hocvien.mahv = chungchi.mahv);
 
 

 /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
    ||10 NGHIEP VU CHUC NANG||
--Câu 1: Dua danh sach hoc vien hoc lop " Tieng anh can ban 1"
set serveroutput on
declare
    cursor dshv is ( select hocvien.mahv,hocvien.tenhv, hocvien.diachi,hocvien.sodt 
    from hocvien,lophoc where hocvien.malh=lophoc.malh and lophoc.tenlh='Tieng Anh can ban 1');
begin
    for i in dshv
    loop
    dbms_output.put_line(' danh sach hoc vien hoc lop " Tieng anh can ban 1" la: ma hoc vien'||i.mahv || ' ten hoc vien '|| i.tenhv || ' Dia chi: '||i.diachi ||' SDT: ' ||i.sodt);
    end loop;
end;

--Câu 2 :Viet ham nhap vao ma lop cho biet lop dang hoc hay da ket thuc
create or replace function hanlop
  (malop in lophoc.malh%type)
return nvarchar2
as
    han number;
    han2 number;
begin
    select sysdate - ngayketthuc, sysdate - ngaybatdau
    into han, han2
    from lophoc 
    where malh=malop;
    if han > 0 then 
         return 'Da hoc xong';
    elsif han < 0 and han2 >= 0 then 
         return 'Dang hoc';
    elsif han < 0 and han2 < 0 then 
         return 'Lop chua m?';
    elsif han = 0 then
         return 'Hom nay la buoi cuoi';
    end if;
    exception
    when no_data_found then
         return ' Khong co ma lop "'||malop||'"!';
end;
----THUC THI----
set serveroutput on
accept malop prompt 'Nhap ma lop hoc:'
declare 
    malop lophoc.malh%type;
begin
    malop:='&malop';
    dbms_output.put_line( hanlop(malop));
end;

select * from khoahoc
select * from lophoc
select * from giaovien

--Câu 3:Nhap vao ten chung chi  cho biet ten hoc vien va diem cua hoc vien do
create or replace procedure nhapcc( tenchungchi chungchi.tencc%type)
as
    cursor cc is (select mahv, tenhv,diem from chungchi join hocvien using (mahv) where tencc=tenchungchi);
    gan cc%rowtype;
    kt exception;
begin
    open cc;
    loop 
    fetch cc into gan;
    exit when cc%notfound;
       dbms_output.put_line(' Hoc vien co ma hoc vien la'||gan.mahv||' ten la: '||gan.tenhv || ' Diem la: '||gan.diem);
    end loop;
    if gan.mahv is null then
        raise kt;
    end if;
    exception
    when kt then
       dbms_output.put_line('Khong co chung chi nao ten la: '||tenchungchi);
    close cc;
end;
--THUC THI---
set serveroutput on
accept tenchungchi prompt 'Nhap ten chung chi:'
declare
    tenchungchi chungchi.tencc%type;
begin
    tenchungchi:='&tenchungchi';
    nhapcc(tenchungchi);
end;

--Câu 4:Nhap vao ma hoc vien cho biet so tien hoc vien do phai dong
set serveroutput on
accept ma prompt 'Nhap ma hoc vien:'
declare
    ma bienlai.mahv%type;
    mahocvien bienlai.mahv%type;
    tien bienlai.sotien%type;
begin
    ma := '&ma';
    select mahv, sotien
    into mahocvien, tien
    from bienlai
    where mahv = ma;
      dbms_output.put_line('hoc vien "'||mahocvien||'" dong so tien la:  '|| tien);
    exception 
    when others then
      dbms_output.put_line('Khong co ma: '|| ma);
end;


--Câu 5:Nhap vao ma hoc vien cho biet thong tin cua hoc vien do
set serveroutput on
accept mahocvien prompt 'Nhap ma hoc vien:'
Declare 
   mahocvien hocvien.mahv%type;
   rowhv hocvien%rowtype;
begin
    mahocvien:='&mahocvien';
    select* 
    into rowhv
    from hocvien
    where mahv=mahocvien;
    dbms_output.put_line('Thong tin hoc vien:');
    dbms_output.put_line('Ma '||rowhv.mahv ||' ten '|| rowhv.tenhv ||' o '|| rowhv.diachi ||' sinh ngay '|| rowhv.ngaysinh ||' so dien thoai '|| rowhv.sodt);
    exception 
    when no_data_found then
      dbms_output.put_line('Khong co ma hoc vien: '||mahocvien);
end;

--Cau 6: tinh tong so tien thu duoc theo ma khoa hoc nhap vao
create or replace function tongtienkh
(ma khoahoc.makh%type)
return float
as
   tien float;
begin
  select sum(sotien)
  into tien
  from bienlai
  where makh = ma;
  return tien;
end;

--chay
set serveroutput on
accept ma prompt 'Nhap ma khoa hoc:'
declare 
ma khoahoc.makh%type;
gan float;
begin
  ma := '&ma';
  gan := tongtienkh(ma);
  if gan > 0 then
    dbms_output.put_line('Tong so tien cua ma khoa hoc "'||ma||'" la '||gan);
  else
    dbms_output.put_line('Khong co ma khoa hoc: '||ma);
  end if;
end;

select * from khoahoc

--Câu 7:Viet thu tuc nhap vao ma lop tra ve ten lop,ngay bat dau,ngay ket thuc cua lop do
create or replace procedure
ttlh ( mlh lophoc.malh%type)
as
  tenl lophoc.tenlh%type;
  ngaybd date;
  ngaykt date;
begin 
  select tenlh, ngaybatdau,ngayketthuc
  into tenl, ngaybd, ngaykt
  from lophoc 
  where malh = mlh;
  dbms_output.put_line('Thong tin lop hoc: '|| tenl||' bat dau ngay '|| ngaybd ||  ' ket thuc ngay ' || ngaykt);
  exception
  when no_data_found then
  dbms_output.put_line('Khong co ma lop hoc: '||mlh);
end;

--THUC THI---
set serveroutput on
accept mlh prompt ' Nhap ma lop hoc:'
begin 
 ttlh('&mlh');
end;

select * from lophoc
--Câu 8:Nhap vao ma hoc vien cho biet ngay thu tien hoc vien do
create or replace procedure
ttbl ( mhv bienlai.mahv%type)
as
  ngay date;
  tien bienlai.sotien%type;
begin 
  select ngaythu, sotien
  into ngay, tien
  from bienlai 
  where mahv = mhv;
  dbms_output.put_line('Ngay thu tien '|| ngay|| ' so tien thu '|| tien);
  exception
  when no_data_found then
    dbms_output.put_line('Khong co ma hoc vien: '||mhv);
end;

--THUC THI---
set serveroutput on
accept mhv prompt ' Nhap ma hoc vien:'
begin 
 ttbl('&mhv');
end;

--Câu 9:Nhap vao ten giao vien,cho biet giao vien do day lop nao,ca may va phong bao nhieu
create or replace procedure ttgv(ten giaovien.tengv%type)
as
  cursor ds is select tengv, tenlh, sophong, tenca from (((giaovien join bangphancong using(magv)) join phonghoc using(sophong)) 
                                                      join cahoc using(maca)) join lophoc using(malh) where tengv = ten;
   gan ds%rowtype;
   kt exception;
begin
  open ds;
  loop
  fetch ds into gan;
  exit when ds%notfound;
     dbms_output.put_line('Giao vien '||gan.tengv||' day lop '||gan.tenlh||' vao '||gan.tenca||' tai phong '||gan.sophong);
  end loop;
  if gan.tengv is null then
    raise kt;
  end if;
  exception
  when kt then
     dbms_output.put_line('Khong co ten giao vien: '||ten);
  close ds;
end;

-- chay
set serveroutput on
accept ten prompt 'Nhap ten giao vien:'
declare 
   ten giaovien.tengv%type;
begin
   ten := '&ten';
   ttgv(ten);
end;

select * from giaovien

--Câu 10:Dua ra danh sach sinh vien theo dia chi nhap vao

set serveroutput on
accept dc prompt 'Nhap vao dia chi:'
declare
    dc hocvien.diachi%type;
    cursor ds is select tenhv from hocvien where diachi = dc;
    kt exception;
    gan ds%rowtype;
begin
    dc := '&dc';
    open ds;
    loop
    fetch ds into gan;
    exit when ds%notfound;
    dbms_output.put_line('hoc vien: '||gan.tenhv);
    end loop;
    close ds;
    if gan.tenhv is null then
      raise kt;
    end if;
    exception
    when kt then
     dbms_output.put_line('Khong co hoc vien nao o '||dc);
end;



-- tao user quanly
create user quanly identified by 123;

--quota
alter user quanly quota unlimited on tbsp1 ;
alter user quanly quota unlimited on tbsp2 ;

--PRIVILEGES & ROLES
grant create session to quanly;
grant dba to quanly ;





---------------------------------------------------------------------------------

/*
/*
-- tao user
create user test1 identified by 123;

-- quyen 
GRANT CONNECT, RESOURCE TO test1;


grant create session to test1;
grant select on hocvien to test1;
GRANT SELECT on giaovien TO test1 ;
GRANT SELECT, INSERT, UPDATE, DELETE ON khoahoc TO test1 ;
GRANT SELECT, INSERT, UPDATE, DELETE ON chungchi TO test1 ;
*/

/*
create user test2 identified by 123456;

grant connect to test2;
ALTER USER "TEST2" DEFAULT ROLE "CONNECT";

grant SELECT, INSERT, UPDATE, DELETE on hocvien to test1;
GRANT SELECT, INSERT, UPDATE, DELETE on giaovien TO test1 ;
GRANT SELECT, INSERT, UPDATE, DELETE ON khoahoc TO test1 ;
GRANT SELECT, INSERT, UPDATE, DELETE ON chungchi TO test1 ;
*/
/*
create user test3 identified by 123456
default tablespace users
temporary tablespace TEMP;

grant create session to test3;
grant SELECT, INSERT, UPDATE, DELETE on hocvien to test3;
GRANT SELECT, INSERT, UPDATE, DELETE on giaovien TO test3 ;
GRANT SELECT, INSERT, UPDATE, DELETE ON khoahoc TO test3 ;
GRANT SELECT, INSERT, UPDATE, DELETE ON chungchi TO test3 ;
*/
/*
CREATE USER "test1sys" IDENTIFIED BY "123"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER "test1sys" DEFAULT ROLE DBA;
*/
/*
SELECT * FROM user_tab_privs_recd;

-- USER SQL
create USER test6 identified by 123
DEFAULT TABLESPACE SYSTEM
TEMPORARY TABLESPACE TEMP;
-- QUOTAS

-- ROLES
grant resource to test6;
grant create session to test6;
grant create view to test6;

grant SELECT, INSERT, UPDATE, DELETE on system.hocvien to test6;
GRANT SELECT, INSERT, UPDATE, DELETE on system.giaovien TO test6 ;
GRANT SELECT, INSERT, UPDATE, DELETE ON system.khoahoc TO test6 ;
GRANT SELECT, INSERT, UPDATE, DELETE ON system.chungchi TO test6 ;


select * from hocvien
CREATE USER test7 IDENTIFIED BY 123 ;

-- PRIVILEGES
GRANT CREATE SESSION TO test7;
GRANT CREATE VIEW TO test7 ;
-- SYSTEM PRIVILEGES

select * from hocvien
CREATE USER "TEST8" PROFILE "DEFAULT" IDENTIFIED BY "*******" DEFAULT TABLESPACE "USERS" TEMPORARY TABLESPACE "TEMP" ACCOUNT UNLOCK
GRANT CREATE ANY TABLE TO "TEST8"
GRANT CREATE SESSION TO "TEST8"
grant select any table to "TEST8"
--grant resource to "TEST8"
GRANT DELETE ON "SYSTEM"."CHUNGCHI" TO "TEST8"
GRANT INSERT ON "SYSTEM"."CHUNGCHI" TO "TEST8"
GRANT SELECT ON "SYSTEM"."CHUNGCHI" TO "TEST8"
GRANT UPDATE ON "SYSTEM"."CHUNGCHI" TO "TEST8"
GRANT DELETE ON "SYSTEM"."DANGKY" TO "TEST8"
GRANT INSERT ON "SYSTEM"."DANGKY" TO "TEST8"
GRANT SELECT ON "SYSTEM"."DANGKY" TO "TEST8"
GRANT UPDATE ON "SYSTEM"."DANGKY" TO "TEST8"
GRANT DELETE ON "SYSTEM"."GIAOVIEN" TO "TEST8"
GRANT INSERT ON "SYSTEM"."GIAOVIEN" TO "TEST8"
GRANT SELECT ON "SYSTEM"."GIAOVIEN" TO "TEST8"
GRANT UPDATE ON "SYSTEM"."GIAOVIEN" TO "TEST8"
GRANT DELETE ON "SYSTEM"."HOCVIEN" TO "TEST8"
GRANT INSERT ON "SYSTEM"."HOCVIEN" TO "TEST8"
GRANT SELECT ON "SYSTEM"."HOCVIEN" TO "TEST8"
GRANT UPDATE ON "SYSTEM"."HOCVIEN" TO "TEST8"
GRANT DELETE ON "SYSTEM"."KHOAHOC" TO "TEST8"
GRANT INSERT ON "SYSTEM"."KHOAHOC" TO "TEST8"
GRANT SELECT ON "SYSTEM"."KHOAHOC" TO "TEST8"
GRANT UPDATE ON "SYSTEM"."KHOAHOC" TO "TEST8"
GRANT DELETE ON "SYSTEM"."PHONGHOC" TO "TEST8"
GRANT INSERT ON "SYSTEM"."PHONGHOC" TO "TEST8"
GRANT SELECT ON "SYSTEM"."PHONGHOC" TO "TEST8"
GRANT UPDATE ON "SYSTEM"."PHONGHOC" TO "TEST8"
GRANT "CONNECT" TO "TEST8"

*/

