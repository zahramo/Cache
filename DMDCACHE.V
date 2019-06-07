module DMDCASHE(
    clk,
    rst,
    address,

    dataOut,
    numOfHits
);
parameter ADDRESSL = 15, WORD = 32;
input clk, rst;
input[ADDRESSL-1:0]address;
output[ADDRESSL-1:0]numOfHits;
output[WORD-1:0]dataOut;

wire[ADDRESSL-1:0]adr0, adr1, adr2, adr3;
wire hit, cRead, cWrite, rRead, rWrite, selOut;
wire[WORD-1:0]dataOutRAM, dataOutCache;
wire[WORD-1:0]block[BLOCKSIZE-1:0];
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
    .dataRtoC(block),
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

endmodule
