`timescale 1ps/1ps
module adrMaker(
    adr,

    adr0,
    adr1,
    adr2,
    adr3
);
parameter WORD = 32;
input[WORD-1:0]adr;
output[word-1:0]adr0, adr1, adr2, adr3;

assign adr0 = {adr[WORD-1:2],2'b00};
assign adr1 = {adr[WORD-1:2],2'b01};
assign adr2 = {adr[WORD-1:2],2'b10};
assign adr3 = {adr[WORD-1:2],2'b11};
endmodule