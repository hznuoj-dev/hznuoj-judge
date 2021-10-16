all: judged.cc
	g++ -Wall -std=c++11 -c -I/usr/local/mysql/include/mysql -I/usr/include/mysql  judged.cc
	g++ -Wall -std=c++11 -o judged judged.o -L/usr/local/mysql/lib/mysql -L/usr/lib/mysql  -L/usr/lib64/mysql  -lmysqlclient
