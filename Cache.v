`timescale 1ps/1ps
module Cache (
    address,
    adr0,
    adr1,
    adr2,
    adr3,
    cRead,
    cWrite,
    dataOutCache,
    dataRtoC,
    hit,
    clk,
    rst
    );
    parameter WORD = 32, LENGTH = 4096, ADDRESSL = 12, BLOCKL = 4, TAG = 3, VALID = 1;
    input [ADDRESSL+TAG-1:0]address, adr0, adr1. adr2, adr3;
    input cRead, cWrite, clk, rst;
    input [WORD-1:0]dataRtoC[BLOCKL-1:0]

    output [WORD-1:0]dataOutCache;
    output hit;

    integer i;
    reg [WORD-1:0]cachMemory[LENGTH-1:0];
    reg [TAG-1:0]tagMemory[LENGTH-1:0];
    reg [VALID-1:0]validMemory[LENGTH-1:0];
    wire [TAG-1:0]tagIn;
    wire [ADDRESSL-1:0]adrInCache
    integer i;
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            for (i = 0; i < LENGTH; i = i + 1)
                validMemory[i] = {WORD*{1'b0}};
        end
        else begin
            if (cWrite) begin
                cachMemory[adr0] = dataOutCache[0];
                cachMemory[adr1] = dataOutCache[1];
                cachMemory[adr2] = dataOutCache[2];
                cachMemory[adr3] = dataOutCache[3];
            end
        end
    end

    assign tagIn = address[ADDRESSL-1:ADDRESSL-4];
    assign adrInCache = address[ADDRESSL-1:0];
    assign hit = validMemory[address] && tagIn == tagMemory[address] ? 1 : 0;
    assign dataOutCache = cRead ? cachMemory[address] : {WORD*{1'bz}};
                      
endmodule
