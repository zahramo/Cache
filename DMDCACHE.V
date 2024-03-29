module DMDCASHE(
    clk1,
    clk2,
    rst,
    address,

    dataOut,
    numOfHits,
    ready,
    req
);
parameter ADDRESSL = 15, WORD = 32, BLOCKSIZE = 4;
input clk1, clk2, rst, req;
input[ADDRESSL-1:0]address;
output[ADDRESSL-1:0]numOfHits;
output[WORD-1:0]dataOut;
output ready;
wire[ADDRESSL-1:0]adr0, adr1, adr2, adr3;
wire hit, cRead, cWrite, rRead, rWrite, selOut, memReady;
wire[WORD-1:0]dataOutRAM, dataOutCache;
wire[WORD-1:0]block0, block1, block2, block3;
wire[14:0]hits;

Cache cache(
    .address(address),
    .adr0(adr0),
    .adr1(adr1),
    .adr2(adr2),
    .adr3(adr3),
    .cRead(cRead),
    .cWrite(cWrite),
    .dataOutCache(dataOutCache),
    .block0(block0), 
    .block1(block1), 
    .block2(block2), 
    .block3(block3),
    .hit(hit),
    .hits(numOfHits), 
    .clk(clk1),
    .rst(rst)
);

adrMaker adrmaker(
    .adr(address),
    .adr0(adr0),
    .adr1(adr1),
    .adr2(adr2),
    .adr3(adr3)
);

cacheCU CU(
    .clk(clk1),
    .rst(rst),
    .hit(hit),
    .req(req),
    .cRead(cRead),
    .cWrite(cWrite),
    .rRead(rRead),
    .rWrite(rWrite),
    .selOut(selOut),
    .memReady(memReady),
    .ready(ready)
);

mux2 m(
    .sel(selOut),
    .inp1(dataOutRAM),
    .inp2(dataOutCache),
    .out(dataOut)
);

DataMemory RAM(
    .clk(clk2),
    .address(address),
    .address0(adr0),
    .address1(adr1),
    .address2(adr2),
    .address3(adr3),
    .memWrite(rWrite),
    .memRead(rRead),
    .writeData(),
    .dataOut(dataOutRAM),
    .block0(block0), 
    .block1(block1), 
    .block2(block2), 
    .block3(block3),
    .memReady(memReady)
);

endmodule
