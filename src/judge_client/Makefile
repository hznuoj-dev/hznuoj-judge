all: judge_client.cc
	g++ -Wall --std=c++11 -c -I/usr/local/mysql/include/mysql -I/usr/include/mysql judge_client.cc
	g++ -Wall --std=c++11 -o judge_client judge_client.o -L/usr/local/mysql/lib/mysql -L/usr/lib/mysql  -L/usr/lib64/mysql -lmysqlclient
