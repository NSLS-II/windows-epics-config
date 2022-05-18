.PHONY: dirs localinstall bundle flatbundle clean

dirs:
	mkdir BUILD
	mkdir INSTALL

localinstall: dirs
	cd installSynApps && python installCLI.py -c .. -b ../BUILD -i ../INSTALL -p -f -y

bundle: dirs
	cd installSynApps && python installCLI.py -c .. -b ../BUILD -i ../INSTALL -p -y -a

flatbundle: dirs
	cd installSynApps && python installCLI.py -c .. -b ../BUILD -i ../INSTALL -p -y -a -f

clean:
	rmdir /S /Q BUILD
	rmdir /S /Q INSTALL