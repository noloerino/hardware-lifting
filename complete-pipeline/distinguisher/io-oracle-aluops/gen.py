import sys

regA = int(sys.argv[1])
regB = int(sys.argv[2])
regDest = int(sys.argv[3])

valA = int(sys.argv[4])
valB = int(sys.argv[5])

op = sys.argv[6]

loadAv = format(valA, '012b')
loadBv = format(valB, '012b')
loadAr = format(10 + regA, '05b')
loadBr = format(10 + regB, '05b')
destRr = format(10 + regDest, '05b')

loadInstA = hex(int(loadAv + "00000000" + loadAr + "0010011", 2))[2:].zfill(8)
loadInstB = hex(int(loadBv + "00000000" + loadBr + "0010011", 2))[2:].zfill(8)


if op == "add":
	opInst = "0000000" + loadBr + loadAr + "000" + destRr + "0110011"
elif op == "sub":
	opInst = "0100000" + loadBr + loadAr + "000" + destRr + "0110011"
elif op == "or":
	opInst = "0000000" + loadBr + loadAr + "110" + destRr + "0110011"
elif op == "and":
	opInst = "0000000" + loadBr + loadAr + "111" + destRr + "0110011"
elif op == "xor":
	opInst = "0000000" + loadBr + loadAr + "100" + destRr + "0110011"
elif op == "ult":
	opInst = "0000000" + loadBr + loadAr + "011" + destRr + "0110011"
else:
	assert False, "Unsupported operation"

opInst = hex(int(opInst, 2))[2:].zfill(8)

print(opInst)

code = """000000000000000000010101464c457f
00000034000001000000000100f30002
00280002002000340000000000008bf8
000000000000000000000001000f0012
00000007000031000000306400000000
00003100000030800000000700001000
00000004000000840000000000003100
00000000000000000000000000000040
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
0000001300000013000000132840006f
00000013000000130000001300000013
00000013000000130000001300000013
00000013000000130000001300000013
0000001300000013000000130000006f
00000013000000130000001300000013
00000013000000130000001300000013
00000013000000130000001300000013
0000001300000013000000130000006f
00000013000000130000001300000013
00000013000000130000001300000013
00000013000000130000001300000013
0000001300000013000000131c40006f
00000013000000130000001300000013
00000013000000130000001300000013
00000013000000130000001300000013
00000213000001930000011300000093
00000413000003930000031300000293
00000613000005930000051300000493
00000813000007930000071300000693
00000a13000009930000091300000893
00000c1300000b9300000b1300000a93
00000e1300000d9300000d1300000c93
0300029300000f9300000f1300000e93
000032b73002a073008002933002b073
300022f33002a0730000c2b73002a073
da63ae23000033970062f3330000c337
00301073080304630062f33300003337
f00001d3f0000153f00000d3f0000053
f00003d3f0000353f00002d3f0000253
f00005d3f0000553f00004d3f0000453
f00007d3f0000753f00006d3f0000653
f00009d3f0000953f00008d3f0000853
f0000bd3f0000b53f0000ad3f0000a53
f0000dd3f0000d53f0000cd3f0000c53
f0000fd3f0000f53f0000ed3f0000e53
df720213000032175241819300003197
00b5706300100593f1002573fc027213
011111130015011300c2023301151613
3412907329c282930000129700410133
0021242300112223ef01011310000073
00612c2300512a230041282300312623
02a12423029122230281202300712e23
02e12c2302d12a2302c1282302b12623
05212423051122230501202302f12e23
05612c2305512a230541282305312623
07a12423079122230781202305712e23
07e12c2307d12a2307c1282307b12623
00010613341025f33420257307f12e23
0081210300412083341510736ed000ef
01812303014122830101220300c12183
02812503024124830201240301c12383
03812703034126830301260302c12583
04812903044128830401280303c12783
05812b0305412a8305012a0304c12983
06812d0306412c8306012c0305c12b83
07812f0307412e8307012e0306c12d83
fe010113100000731101011307c12f83
feb42423fea426230201041300812e23
00000793""" + opInst + loadInstB + loadInstA + """
000080670201011301c1240300078513
fea426230201041300812e23fe010113
01c1240300000013fec42223feb42423
00812e23fe0101130000806702010113
fec42223feb42423fea4262302010413
000080670201011301c1240300000013
fca426230401041302812e23fc010113
0a80006ffe042623fcc42223fcb42423
00f707b3fc84270300279793fec42783
00178793fec42783fef424230007a783
0007a78300f707b3fc84270300279793
fc44270300279793fec42783fef42223
fec42783fef420230007a78300f707b3
00f707b3fc4427030027979300178793
fe042783fe842703fcf42e230007a783
0a00006f00178793fec4278300f70863
fec4278300f70863fdc42783fe442703
00278793fec427830880006f00278793
00f707b301f7d713fcc42783fef42623
f4e7c2e3fec42783001797134017d793
fcc42703040788630017f793fcc42783
0027979300f707b3fff78793400007b7
fcc426830007a70300f707b3fc842703
0027979300f687b3fff78793400007b7
00f706630007a78300f687b3fc442683
00078513000007930080006ffcc42783
fb010113000080670401011303c12403
fab42c23faa42e230501041304812623
fec427830c40006ffe042623fac42a23
0007b78700f707b3fb84270300379793
0037979300178793fec42783fef43027
fcf43c270007b78700f707b3fb842703
00f707b3fb44270300379793fec42783
00178793fec42783fcf438270007b787
0007b78700f707b3fb44270300379793
a2f727d3fd043787fe043707fcf43427
fc843787fd843707fcf422230ff7f793
fc442703fcf420230ff7f793a2f727d3
fec4278300079c6300f777b3fc042783
08c0006f00f707b3fc44278300178713
fbc42783fef4262300278793fec42783
001797134017d79300f707b301f7d713
0017f793fbc42783f2e7c4e3fec42783
fff78793200007b7fbc4270304078a63
00f707b3fb8427030037979300f707b3
fff78793200007b7fbc427030007b707
00f707b3fb4427030037979300f707b3
fbc4278300079663a2f727d30007b787
04c1240300078513000007930080006f
00812e23fe0101130000806705010113
000227830330000ffea4262302010413
00e22023000787130ff7f7930017b793
0006871306e7a6af8941879300100713
8801aa2300f71a63fff78793fec42783
000000130140006f88e1ac2300022703
0330000ffef71ce3000227838981a703
000080670201011301c1240300000013
033122230321242302812623fd010113
fdc42783fcb42e23fca42c2303010413
0127e93300175913fd84270301f79793
0127cf33fd8427830017d993fdc42783
fef42423001f77930137cfb3fdc42783
01f79793fdc42783fef42623000ff793
fdc4278301c7ee3300175e13fd842703
0000081301e79893fe8427830017de93
0006879300060713011ee6b3010e6633
0281290302c124030007859300070513
fd010113000080670301011302412983
03010413033122230321242302812623
fcd42823fcc42a23fcb42c23fca42e23
0067d79303f7879300010793f8010113
41f7571300070913fdc4270300679793
fd8427030137a2230127a02300070993
01e7a42300070f9341f7571300070f13
41f7571300070e13fd44270301f7a623
fd04270301d7aa2301c7a82300070e93
0107ac230007089341f7571300070813
78071073000787130330000f0117ae23
fee42623781717730000071300000013
0047a7830007a703fe0708e3fec42703
02c12403fd0401130007851300070793
00008067030101130241298302812903
f8a42e230701041306812623f9010113
fa0422230c00e57300078463f9c42783
c0002573fee7cce301100793fa442703
04079063f9c42783fef4262300050793
00f707b38041879300271713fa442703
fef4262340f707b3fec427030007a783
00f707b384c1879300271713fa442703
fa44278300e7a023cd87071300003737
8041879300279713fae4222300178713
fa44270300e7a023fec4270300f707b3
00050793c0202573fee7cce301100793
fa44270304079063f9c42783fef42423
0007a78300f707b38041879300271713
fa442703fef4242340f707b3fe842703
0000373700f707b384c1879300271713
00178713fa44278300e7a023ce070713
00f707b38041879300279713fae42223
01100793fa44270300e7a023fe842703
fef4222300050793cc002573fee7cce3
00271713fa44270304079063f9c42783
fe4427030007a78300f707b380418793
00271713fa442703fef4222340f707b3
ce8707130000373700f707b384c18793
fae4222300178713fa44278300e7a023
fe44270300f707b38041879300279713
fee7cce301100793fa44270300e7a023
f9c42783fef4202300050793cc102573
8041879300271713fa44270304079063
40f707b3fe0427030007a78300f707b3
84c1879300271713fa442703fef42023
00e7a023cf0707130000373700f707b3
00279713fae4222300178713fa442783
00e7a023fe04270300f707b380418793
cc202573fee7cce301100793fa442703
04079063f9c42783fcf42e2300050793
00f707b38041879300271713fa442703
fcf42e2340f707b3fdc427030007a783
00f707b384c1879300271713fa442703
fa44278300e7a023cf87071300003737
8041879300279713fae4222300178713
fa44270300e7a023fdc4270300f707b3
00050793cc302573fee7cce301100793
fa44270304079063f9c42783fcf42c23
0007a78300f707b38041879300271713
fa442703fcf42c2340f707b3fd842703
0000373700f707b384c1879300271713
00178713fa44278300e7a023d0070713
00f707b38041879300279713fae42223
01100793fa44270300e7a023fd842703
fcf42a2300050793cc402573fee7cce3
00271713fa44270304079063f9c42783
fd4427030007a78300f707b380418793
00271713fa442703fcf42a2340f707b3
d08707130000373700f707b384c18793
fae4222300178713fa44278300e7a023
fd44270300f707b38041879300279713
fee7cce301100793fa44270300e7a023
f9c42783fcf4282300050793cc502573
8041879300271713fa44270304079063
40f707b3fd0427030007a78300f707b3
84c1879300271713fa442703fcf42823
00e7a023d10707130000373700f707b3
00279713fae4222300178713fa442783
00e7a023fd04270300f707b380418793
cc602573fee7cce301100793fa442703
04079063f9c42783fcf4262300050793
00f707b38041879300271713fa442703
fcf4262340f707b3fcc427030007a783
00f707b384c1879300271713fa442703
fa44278300e7a023d187071300003737
8041879300279713fae4222300178713
fa44270300e7a023fcc4270300f707b3
00050793cc702573fee7cce301100793
fa44270304079063f9c42783fcf42423
0007a78300f707b38041879300271713
fa442703fcf4242340f707b3fc842703
0000373700f707b384c1879300271713
00178713fa44278300e7a023d2070713
00f707b38041879300279713fae42223
01100793fa44270300e7a023fc842703
fcf4222300050793cc802573fee7cce3
00271713fa44270304079063f9c42783
fc4427030007a78300f707b380418793
00271713fa442703fcf4222340f707b3
d28707130000373700f707b384c18793
fae4222300178713fa44278300e7a023
fc44270300f707b38041879300279713
fee7cce301100793fa44270300e7a023
f9c42783fcf4202300050793cc902573
8041879300271713fa44270304079063
40f707b3fc0427030007a78300f707b3
84c1879300271713fa442703fcf42023
00e7a023d30707130000373700f707b3
00279713fae4222300178713fa442783
00e7a023fc04270300f707b380418793
cca02573fee7cce301100793fa442703
04079063f9c42783faf42e2300050793
00f707b38041879300271713fa442703
faf42e2340f707b3fbc427030007a783
00f707b384c1879300271713fa442703
fa44278300e7a023d387071300003737
8041879300279713fae4222300178713
fa44270300e7a023fbc4270300f707b3
00050793ccb02573fee7cce301100793
fa44270304079063f9c42783faf42c23
0007a78300f707b38041879300271713
fa442703faf42c2340f707b3fb842703
0000373700f707b384c1879300271713
00178713fa44278300e7a023d4070713
00f707b38041879300279713fae42223
01100793fa44270300e7a023fb842703
faf42a2300050793ccc02573fee7cce3
00271713fa44270304079063f9c42783
fb4427030007a78300f707b380418793
00271713fa442703faf42a2340f707b3
d48707130000373700f707b384c18793
fae4222300178713fa44278300e7a023
fb44270300f707b38041879300279713
fee7cce301100793fa44270300e7a023
f9c42783faf4282300050793ccd02573
8041879300271713fa44270304079063
40f707b3fb0427030007a78300f707b3
84c1879300271713fa442703faf42823
00e7a023d50707130000373700f707b3
00279713fae4222300178713fa442783
00e7a023fb04270300f707b380418793
cce02573fee7cce301100793fa442703
04079063f9c42783faf4262300050793
00f707b38041879300271713fa442703
faf4262340f707b3fac427030007a783
00f707b384c1879300271713fa442703
fa44278300e7a023d587071300003737
8041879300279713fae4222300178713
fa44270300e7a023fac4270300f707b3
00050793ccf02573fee7cce301100793
fa44270304079063f9c42783faf42423
0007a78300f707b38041879300271713
fa442703faf4242340f707b3fa842703
0000373700f707b384c1879300271713
00178713fa44278300e7a023d6070713
00f707b38041879300279713fae42223
00079463f9c4278300e7a023fa842703
06c1240300078513000007930c00f573
00812e23fe0101130000806707010113
00179793fec42783fea4262302010413
fd0101130000006f780790730017e793
fca42e23030104130281242302112623
0c002573008007effcc42a23fcb42c23
00200793fdc42703fe042623fef42423
fe8427830007a703fd84278302f71263
0007a783fe84278300f777330007a783
00f7086300800793fdc427030af70c63
fd4427830a00006ff75ff0ef53900513
00f71e6305d007930007a70304478793
000785130007a78302878793fd442783
04478793fd4427830740006ff49ff0ef
fd44278302f710634d2007930007a703
e24ff0ef000785130007a78302878793
04478793fd4427830440006ffea42623
0007a58302878793fd4427830007a703
fd4427830007a60302c78793fd442783
00070513000786930007a78303078793
02878793fd442783fea42623cfcff0ef
00478793fd84278300e7a023fec42703
030101130281240302c1208300078513
0201041300812e23fe01011300008067
fed42023fec42223feb42423fea42623
fe042603fe442583fe842503fec42883
01c12403000785130005079300000073
00112e23fe0101130000806702010113
00000693fea426230201041300812c23
f99ff0ef05d00513fec4258300000613
00812c2300112e23fe0101130000006f
0000061300000693fea4262302010413
00000013f6dff0ef4d200513fec42583
00008067020101130181240301c12083
00912a2300812c2300112e23fe010113
fec42503fec42483fea4262302010413
000486130007869300050793629000ef
00000013f1dff0ef0400051300100593
02010113014124830181240301c12083
0201041300812e23fe01011300008067
fe079ee3fec42783feb42423fea42623
000080670201011301c1240300000013
0201041300812c2300112e23fe010113
d6878513000037b7feb42423fea42623
01c1208300078513fff00793f61ff0ef
fe010113000080670201011301812403
000207130201041300812c2300112e23
00020713fef4262340f707b300020793
361000ef0007051389c18593fec42603
fef4242340f707b30002079308420713
fe84260300f707b3fec4278300020713
00000013455000ef0007851300000593
00008067020101130181240301c12083
029122230281242302112623fd010113
d8010113fcb42c23fca42e2303010413
006794930067d79303f7879300010793
ee9ff0effdc42503fd842583f5dff0ef
fea42223e45fe0ef0000051300000593
fe8427030780006ffe042423fe942623
0007a78300f707b38041879300271713
84c1879300271713fe84270304078a63
00271713fe8427030007a60300f707b3
000786930007a78300f707b380418793
191000effec42503d8078593000037b7
00e787b3fec427830007871300050793
fef4242300178793fe842783fef42623
fec42783f8e7d2e301100793fe842703
fe442503de9ff0ef0004851300f48663
00812c2300112e23fe010113d79ff0ef
0017869308022783fea4262302010413
040206930ff77713fec4270308d22023
00a00793fec4270300e7802300d787b3
02f71263040007930802270300f70863
00070613000786930802278304020713
08022023ccdff0ef0400051300100593
0181240301c120830007851300000793
02112e23fc0101130000806702010113
fcb42623fca424230401041302812c23
fec4278300f0071308c0006ffe042623
0ff7f71300f7f793fc84478340f706b3
0007f893fcc4278300f7f813fc842783
0107e663009007930008966300089c63
00f707b3057007930080006f03000793
fee7842300d787b3ff0407930ff7f713
00475713fc84270301c79793fcc42783
0047d793fcc42783fcf4242300f767b3
fef4262300178793fec42783fcf42623
fe040423f6e7d8e300f00793fec42703
00000013c99ff0ef00078513fd840793
00008067040101130381240303c12083
14912a2314812c2314112e23ea010113
15512223154124231531262315212823
eaa42e231601041313712e2315612023
eae42623ead42a23eac42823eab42c23
fcc42483fc042623eb042223eaf42423
00078a13eac42783fcf4262300148793
000a0613eb442783eb04270300000a93
7b5000ef0007859300070513000a8693
fd040693002497930005879300050713
00078b13eac42783eee7ae2300f687b3
04e7e863000b8713eb44278300000b93
eb04278300e79863000b8713eb442783
00078913eac4278302e7ec63000b0713
eb042503000986930009061300000993
00058793000507132b9000efeb442583
00000013f55ff06feaf42a23eae42823
ea442503eb842583ebc427830140006f
eae42423fff78713ea842783000780e7
fcc427830540006ffef740e3fcc42703
efc7a70300f707b3fd04071300279793
00f687b3fd04069300279793fcc42783
0570079300d7f66300900793efc7a683
ebc4270300f707b3030007930080006f
fcc42783000700e700078513eb842583
00000013faf042e3fce42623fff78713
15012903154124831581240315c12083
14012b0314412a8314812a0314c12983
fe010113000080671601011313c12b83
feb42423fea426230201041300812e23
fec4278302e7d66300100793fe842703
00878693ff87f793007787930007a783
0047a8830007a80300d72023fec42703
fec4278302078463fe8427830500006f
00d72023fec42703004786930007a783
0240006f00000893000788130007a783
fec42703004786930007a783fec42783
00000893000788130007a78300d72023
00078593000705130008879300080713
fe010113000080670201011301c12403
feb42423fea426230201041300812e23
fec4278302e7d66300100793fe842703
00878693ff87f793007787930007a783
0047a8830007a80300d72023fec42703
fec4278302078663fe8427830580006f
00d72023fec42703004786930007a783
0007889341f7d793000788130007a783
004786930007a783fec427830280006f
000788130007a78300d72023fec42703
00088793000807130007889341f7d793
0201011301c124030007859300070513
0481242304112623fb01011300008067
faa42e23050104130521202304912223
0240006ffad42823fac42a23fab42c23
faf42a2300178793fb4427833a048c63
000780e700048513fb842583fbc42783
02500793000784930007c783fb442783
faf42a2300178793fb442783fcf498e3
fcf40ba302000793fcf42823fb442783
fcf42c23fff00793fcf42e23fff00793
00178713fb442783fc042623fe042023
fdd48793000784930007c783fae42a23
000037b70027971330f76a6305500713
000780670007a78300f707b3d9478793
03000793fc1ff06ffcf40ba302d00793
fd842783fc042c23fb5ff06ffcf40ba3
009787b300e787b30027971300179793
0007c783fb442783fcf42c23fd078793
039007930497d86302f0079300078493
faf42a2300178793fb4427830497c463
fae4282300478713fb042783fbdff06f
fdc427830240006ffcf42c230007a783
00100793f41ff06ffc042e23f407d4e3
fdc4278300000013f35ff06ffcf42623
fff00793fcf42e23fd842783f207d4e3
00178793fe042783f15ff06ffcf42c23
00478713fb042783f05ff06ffef42023
fb842583fbc427030007a783fae42823
fb04278322c0006f000700e700078513
000916630007a903fae4282300478713
08f05063fdc42783d8c78913000037b7
fd84278306f70a6302d00793fd744703
00050713640000ef0009051300078593
0240006ffcf42e2340e787b3fdc42783
00078513fb842583fbc42703fd744783
fcf42e23fff78793fdc42783000700e7
fbc427830240006ffcf04ee3fdc42783
00190913000780e700048513fb842583
00094783fcf42e23fff78793fdc42783
fc07c8e3fd8427830404806300078493
fd842783fcf42c23fff78793fd842783
fb842583fbc427830200006ffa07dee3
fff78793fdc42783000780e702000513
1380006ffef040e3fdc42783fcf42e23
c91ff0ef00078513fe042583fb040793
fef42623fee424230005879300050713
fbc427830407d463fec42783fe842703
fe842503000780e702d00513fb842583
40a806330000089300000813fec42583
0007869340f687b340b886b300c837b3
fef42623fee424230006879300060713
00a007930640006ffef4222300a00793
fef42223008007930400006ffef42223
fbc42783fef42023001007930340006f
fbc42783000780e703000513fb842583
01000793000780e707800513fb842583
00078513fe042583fb040793fef42223
fe442703feb42623fea42423b1dff0ef
fe842603fdc4278300078813fd744783
935ff0effbc42503fb842583fec42683
00048513fb842583fbc427830340006f
fb842583fbc427830200006f000780e7
faf42a23fd042783000780e702500513
04c1208300000013c49ff06f00000013
05010113040129030441248304812403
0281242302112623fb01011300008067
00c4242300b42223fca42e2303010413
01042c2300f42a2300e4282300d42623
fef42623fe4787930204079301142e23
00000593fdc4260300078693fec42783
00000793badff0ef70478513000017b7
050101130281240302c1208300078513
0301041302812623fd01011300008067
fd842783fc542a23fcb42c23fca42e23
fdc427030007a783fec42783fef42623
0007a783fec4278300e780230ff77713
0000001300e7a023fec4278300178713
f6010113000080670301011302c12403
f8a426230801041306812c2306112e23
00e4282300d4262300c42423f8b42423
f984079301142e2301042c2300f42a23
0142a6b700d7a02329700693f9840713
283686930102a6b700d7a22330368693
00d7a62306768693000306b700d7a423
00e7aa23ff4707130000273700e7a823
02040793fef42623f8c427830000100f
f9840793fe842703fef42423fe878793
f884260300070693f8c4079300078513
00078023f8c42783a91ff0ef00078593
40f707b3fec4278300078713f8c42783
0a0101130781240307c1208300078513
00a5c7b30000806740b5053300008067
003007930e07926300c508b30037f793
ffc8f81304079a63003577930ec7fe63
0005869306f5666300050713fe080793
004787930006a6030307786300070793
fff74793ff07e8e3fec7ae2300468693
0107073300480813ffc8781301078833
000507130000806709176863010585b3
fed70fa300377793001707130005c683
fe080793ffc8f813fe0796e300158593
0085af830045a2830005a383f8f77ee3
0185a3030145ae030105ae8300c5af03
ffc5a683024707130245859301c5a603
ffe72423fff72223fe572023fc772e23
fec72c23fe672a23ffc72823ffd72623
00050713f45ff06ffaf768e3fed72e23
00158593001707130005c78303157463
0005071300008067ff1768e3fef70fa3
00f0081300008067f55ff06fff1562e3
0a07906300f7779302c87e6300050713
00e686b300f67613ff06769308059263
00b7262300b7242300b7222300b72023
0000806700061463fed766e301070713
005686b3000002970026969340c806b3
00b7062300b706a300b7072300c68067
00b7042300b704a300b7052300b705a3
00b7022300b702a300b7032300b703a3
00b7002300b700a300b7012300b701a3
00d5e5b3008596930ff5f59300008067
00279693f6dff06f00d5e5b301059693
fa0680e700008293005686b300000297
00f6063340f70733ff07879300028093
0005059300357793f3dff06ff6c878e3
fff00613f7f686937f7f86b704079a63
00d7073300d7f733ffc5278300450513
ffc54703fec784e300f767b300d7e7b3
02070e63ffe54603ffd5468340b507b3
0000806702060c63fff7851302068863
003577130015051300054783fa070ae3
00008067fff5051340b50533fe0798e3
00008067ffc7851300008067ffd78513
0005478302058e6300008067ffe78513
0100006f00b505b30015079302078a63
001787130007079300068c63fff74683
40a785330000806740a58533fef598e3
00068313000080670000051300008067
0c069e630005881300050e1300060893
0ff0079322f67e63000107b712c5fc63
00f656b3000037370037979300c7b7b3
020006930007470300e68733eec70713
00d5973300068c6340f686b300f707b3
00d51e3300e7e83300d618b300f557b3
0106d6930108969302c855330108d613
0107171302a685b302c87733010e5793
fff507930118083300b87c6300e7e833
40b80833000785133eb8686301186463
02c87833010e5e13010e1e1302c85733
00d87c63010e68330108181302e686b3
ffe7071335186663fff7079301088833
0000059300e567b30105151334d87263
000107b712d5ee630000806700078513
0017471300e6b7330100073714f6e263
000037b7010707130087771340e00733
0007c78300f887b3eec7879300e6d8b3
140e126340ee0e3300e7873302000e13
00c537b30f036a630010079300000593
00100893000616630e80006f0017c793
010007b70ef8e663000107b702c8d8b3
0087f79340f007b30017c79300f8b7b3
eec7071300f8d6b30000373701078793
00f3033302000e930007430300e68733
41158733010896131c0e9663406e8eb3
010e581300100593010656130108d693
0107171302c5033302d7773302d75533
fff50713011787b30067fc6300e867b3
406787b3000705132a67e2630117e463
02d7f7b3010e5e13010e1e1302d7d733
00c7fc6300fe67b30107979302c70633
ffe707132117e263fff7069300f887b3
0007851300e567b3010515131ec7fe63
00078513000007930000059300008067
0037171300d737330ff0071300008067
003797930117b7b30ff00793ecdff06f
0017c79300f637b3010007b7f25ff06f
dbdff06f010787930087f79340f007b3
00e5d33300f6e6b301c696b300e657b3
00e557330106981303e35eb30106df13
0105d89300b765b301c595b301085813
0103131303d8073303e3733301c61633
fffe879300d888b300e8fa630068e8b3
03e8d33340e888b300078e9318d8fc63
0268083303e8f8b30105d59301059593
00d7073301077a630115e73301089893
010e9e930007831314d77a63fff30793
00def5b3fff78693006eeeb3000107b7
02d583330106561300d676b3010ed893
02c585b30103581302d886b341070733
00d5f46302c8883300b805b300d585b3
0f076863010888330105d89300f80833
ed1ff06f00000593000e87930d070663
02f658330108d7930065d63301d898b3
00655333010f5f1301d5973301089f13
02f6763301d51e330103569300e36333
00e6fe6300c6e6b301061613030f0733
0ce6f2630d16e463fff80613011686b3
02f6d5b340e686b3011686b3ffe80813
02bf063302f6f6b30103531301031313
0117073300c77e6300d3673301069693
ffe5859308c7706309176263fff58693
00b865b340c707330108181301170733
00068713da5ff06f00078693000f0613
000106b7cbdff06f00078713e05ff06f
00d376b30105959300d5f5b3fff68693
fffe8793f0d77ee300d586b301c51733
ffe30313eb0778e3de9ff06f00000593
ffee8e93e6e8f6e3ea9ff06f00d70733
f89ff06f00068593e65ff06f00d888b3
011787b3ffe50513f45ff06f00060813
c11ff06f01180833ffe50513d5dff06f
00058e13000508930006871300060813
20f66863000107b714c5f2630c069c63
40f007b30017c79300f637b3010007b7
00f656b300003737010787930087f793
020003130007468300e68733eec70713
006595b300030c6340f3033300f687b3
006518b300b7ee330066183300f557b3
010656130108161303de55b301085e93
0106969302b605b303de76b30108d713
010764630107073300b7786300d76733
0108989303d757b340b7073338b76863
0107171302f6053303d777330108d893
0107e663010787b300a7fa6300e8e7b3
0067d53340a787b3010787b300a7f463
000107b7fed5eee30000806700000593
0017c79300f6b7b3010007b710f6ee63
00003337010787930087f79340f007b3
00034f03006e8333eec3031300f6deb3
100e986341ee8eb300ff0f3302000e93
40c507b30108ea630005079301c76663
0007851340a58e3300f5353340d585b3
001008130006166300008067000e0593
010007b70af86a63000107b702c85833
0087f79340f007b30017c79300f837b3
eec7071300f856b30000373701078793
00f707b3020003130007470300e68733
410585b3010815131c03106340f30333
02d5d6330108d7130105551301085693
00b767330105959302a6063302d5f5b3
00c77463010766630107073300c77a63
0108979302d7563340c7073301070733
0107171302a6053302d777330107d793
0ff00793ec1ff06feca7fae300e7e7b3
0ff00793ef5ff06f0037979300d7b7b3
0ff00793f5dff06f003797930107b7b3
01e65733e01ff06f0037979300c7b7b3
0106df9301e5d33300e6e6b301d696b3
01d617b3010757130106971303f35e33
010858930105e83301e555b301d59833
0103131303c7063303f3733301d51533
fffe059300d888b300c8fa630068e8b3
03f8d33340c888b300058e1318d8f863
0267073303f8f8b30108581301081813
00d8083300e87a630118683301089893
010e1e130006031314d87663fff30613
00b37633fff28593006e6333000102b7
02b60fb30107d31300b7f5b301035e13
02be05b3010fd8930266063340e80733
00b87463026e033300c8883300b60633
01085613fff605930001063700530333
00bff833006603330108189300b87833
40670733106700630c67626301088833
40a7073300f5353340f507b300080793
01d755b300f5653301d7d7b301e71533
0108571300f5d6b30068183300008067
010e5e13006595b301081e1302e6d633
006518b30107de9300b7e7b300f557b3
00dee6330106969302ce05b302e6f6b3
00b67463010666630106063300b67a63
0107979302e655b340b6063301060633
0106161302be05b302e676330107d793
0106e663010686b300b6fa6300c7e6b3
000e051340b685b3010686b300b6f463
40d306b340f807b3dc5ff06f00070693
f39ff06f410707334106883300f83833
eb1ff06f00d80833ffe30313eae87ce3
e6dff06f00d888b3ffee0e13e6c8fae3
00080793fd0560e3c71ff06f01070733
000000656c637963f01ff06f00000713
00003068637261750074657274736e69
00003268637261750000316863726175
00003468637261750000336863726175
00003668637261750000356863726175
00003868637261750000376863726175
00303168637261750000396863726175
00323168637261750031316863726175
00343168637261750033316863726175
6e656d656c706d490035316863726175
000a216f6f66202c29286e69616d2074
6c756e28000000000a6425203d207325
00001f3400001f4800001cdc0000296c
00001f4800001f4800001f4800001f48
00001c5000001f4800001f4800001cb4
00001c6800001c5c00001f4800001ccc
00001c6800001c6800001c6800001c68
00001c6800001c6800001c6800001c68
00001f4800001f4800001f4800001f48
00001f4800001f4800001f4800001f48
00001f4800001f4800001f4800001f48
00001f4800001f4800001f4800001f48
00001f4800001f4800001f4800001f48
00001f4800001f4800001f4800001f48
00001f4800001f4800001f4800001f48
00001f4800001f4800001f4800001f48
00001f4800001f4800001f4800001f48
00001f4800001f4800001f4800001f48
00001f4800001e3000001d1800001f48
00001f4800001f4800001f4800001f48
00001f4800001d0800001f4800001f48
00001f4800001ec400001eb800001f48
00001eac00001f4800001d3c00001f48
0202010000001eec00001f4800001f48
05050505040404040404040403030303
06060606050505050505050505050505
06060606060606060606060606060606
07070707060606060606060606060606
07070707070707070707070707070707
07070707070707070707070707070707
07070707070707070707070707070707
08080808070707070707070707070707
08080808080808080808080808080808
08080808080808080808080808080808
08080808080808080808080808080808
08080808080808080808080808080808
08080808080808080808080808080808
08080808080808080808080808080808
08080808080808080808080808080808
00000010080808080808080808080808
00020d1b0101040100527a0100000000
00000120fffff1240000001800000010
fffff30c0000002c0000001000000000
00000040000000100000000000000090
000000100000000000000044fffff388
0000000000000494fffff3b800000054
00000448fffff8380000006800000010"""

fout = open(sys.argv[7], 'w')

fout.write(code)

for i in range(775, 32769):
	fout.write("00000000000000000000000000000000\n")

fout.close()