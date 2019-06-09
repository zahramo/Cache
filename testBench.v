`timescale 1ps/1ps
module TestBench2 ();
    parameter CLK = 100;
    parameter WORD = 32, ADDRESSL = 15;
    reg clk = 0;
    reg rst = 0;
    reg req;
    reg [ADDRESSL-1:0]adr;
    wire [ADDRESSL-1:0]numOfHits;
    wire [WORD-1:0]dataOut;
    wire ready;
    DMDCASHE UUT(
    .clk(clk),
    .rst(rst),
    .address(adr),
    .dataOut(dataOut),
    .numOfHits(numOfHits),
    .ready(ready),
    .req(req)
    );
    integer i;
    always #CLK clk = ~clk;
    always @(posedge ready) begin
        req = 1;
        adr = 1024 + i;
        if (i < 8192)
            i = i + 1;
        else begin
            #(2*CLK) $stop;
        end
    end
    initial begin 
        i = 0;
        #(2*CLK) rst = 1;
        #(2*CLK) rst = 0;
        // #(38000*CLK)
        // $stop;
    end


endmodule