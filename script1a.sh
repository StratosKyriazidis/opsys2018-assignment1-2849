myfunc1()
{
	mkdir ~/htmlfiles;
	cd ~/htmlfiles;
	if wget -i ~/loa -q;
	then
		echo "http://www.tldp.org FAILED \
		https://en.wikipedia.org/wiki/Linux FAILED \
		https://www.gnu.org/software/bash/ FAILED" > /dev/stderr;
	else
		echo "http://www.tldp.org INIT \
       		https://en.wikipedia.org/wiki/Linux INIT \
		https://www.gnu.org/software/bash/ INIT";
	fi
	cd ~/;
}

myfunc2()
{
	mkdir ~/temphtml;
	cd ~/temphtml;
	if wget -i ~/loa -q;
	then
		echo "http://www.tldp.org FAILED \
		https://en.wikipedia.org/wiki/Linux FAILED \
		https://www.gnu.org/software/bash/ FAILED" > /dev/stderr;
	else 
	{
		diff ~/htmlfiles/index.html ~/temphtml/index.html > /dev/null 2>&1;
		if [ $? -eq 1 ]
		then
		{
			echo "http://www.tldp.org";
			cat ~/temphtml/index.html > ~/htmlfiles/index.html;
			rm ~/temphtml/index.html;
		}
		else
			rm ~/temphtml/index.html;
		fi

		diff ~/htmlfiles/index.html.1 ~/temphtml/index.html.1 > /dev/null 2>&1;
		if [ $? -eq 1 ]
		then
		{
			echo "https://www.gnu.org/sofware/bash/";
			cat ~/temphtml/index.html.1 > ~/htmlfiles/index.html.1;
			rm ~/temphtml/index.html.1;
		}
		else
			rm ~/temphtml/index.html.1;
		fi

		diff ~/htmlfiles/Linux ~/temphtml/Linux > /dev/null 2>&1;
		if [ $? -eq 1 ]
		then
		{
			echo "https://en.wikipedia.org/wiki/Linux";
			cat ~/temphtml/Linux > ~/htmlfiles/Linux;
			rm ~/temphtml/Linux;
		}
		else
			rm ~/temphtml/Linux;
		fi
	}
	fi	
	rmdir ~/temphtml;
}

if [ -d ~/htmlfiles ]
then
	myfunc2;
else
	myfunc1;
fi
