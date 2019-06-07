module DMDCASHE(
    clk,
    rst,
    address,

    dataOut,
    numOfHits
);
parameter ADDRESSL = 15, WORD = 32, BLOCKSIZE = 4;
input clk, rst;
input[ADDRESSL-1:0]address;
output[ADDRESSL-1:0]numOfHits;
output[WORD-1:0]dataOut;

wire[ADDRESSL-1:0]adr0, adr1, adr2, adr3;
wire hit, cRead, cWrite, rRead, rWrite, selOut;
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
    .hits(hits), 
    .clk(clk),
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
    .clk(clk),
    .rst(rst),
    .hit(hit),

    .cRead(cRead),
    .cWrite(cWrite),
    .rRead(rRead),
    .rWrite(rWrite),
    .selOut(selOut)
);

mux2 m(
    .sel(selOut),
    .inp1(dataOutRAM),
    .inp2(dataOutCache),
    .out(dataOut)
);

DataMemory RAM(
    .clk(clk),
    .address(address),
    .address0(address0),
    .address1(address1),
    .address2(address2),
    .address3(address3),
    .memWrite(rWrite),
    .memRead(rRead),
    .writeData(),
    .dataOut(dataOutRAM),
    .block0(block0), 
    .block1(block1), 
    .block2(block2), 
    .block3(block3)
);

endmodule
