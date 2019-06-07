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
    hits,
    clk,
    rst
    );
    parameter WORD = 32, LENGTH = 4096, ADDRESSL = 12, BLOCKL = 4, TAG = 3, VALID = 1;
    input [ADDRESSL+TAG-1:0]address, adr0, adr1. adr2, adr3;
    input cRead, cWrite, clk, rst;
    input [WORD-1:0]dataRtoC[BLOCKL-1:0]

    output [WORD-1:0]dataOutCache;
    output hit;
    output [14:0] hits;

    integer i;
    reg [WORD-1:0]cachMemory[LENGTH-1:0];
    reg [TAG-1:0]tagMemory[LENGTH-1:0];
    reg [VALID-1:0]validMemory[LENGTH-1:0];
    wire [TAG-1:0]tagIn;
    wire [ADDRESSL-1:0]adrInCache
    integer i;
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            hits = 0;
            for (i = 0; i < LENGTH; i = i + 1)
                validMemory[i] = 1'b0;
        end
        else begin
            if (cWrite) begin
                cachMemory[adr0[ADDRESSL-1:0]] = dataOutCache[0];
                tagMemory[adr0[ADDRESSL-1:0]] = adr0[ADDRESSL+TAG-1:ADDRESSL+TAG-4]
                validMemory[adr0[ADDRESSL-1:0]] = 1'b1;

                cachMemory[adr1[ADDRESSL-1:0]] = dataOutCache[1];
                tagMemory[adr1[ADDRESSL-1:0]] = adr1[ADDRESSL+TAG-1:ADDRESSL+TAG-4]
                validMemory[adr1[ADDRESSL-1:0]] = 1'b1;

                cachMemory[adr2[ADDRESSL-1:0]] = dataOutCache[2];
                tagMemory[adr2[ADDRESSL-1:0]] = adr2[ADDRESSL+TAG-1:ADDRESSL+TAG-4]
                validMemory[adr2[ADDRESSL-1:0]] = 1'b1;

                cachMemory[adr3[ADDRESSL-1:0]] = dataOutCache[3];
                tagMemory[adr3[ADDRESSL-1:0]] = adr3[ADDRESSL+TAG-1:ADDRESSL+TAG-4]
                validMemory[adr3[ADDRESSL-1:0]] = 1'b1;
            end
            if (hit)
                hits = hits + 1;
        end
    end

    assign tagIn = address[ADDRESSL+TAG-1:ADDRESSL+TAG-4];
    assign adrInCache = address[ADDRESSL-1:0];
    assign hit = validMemory[adrInCache] && tagIn == tagMemory[adrInCache] ? 1 : 0;
    assign dataOutCache = cRead ? cachMemory[adrInCache] : {WORD*{1'bz}};
                      
endmodule
