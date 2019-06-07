`timescale 1ps/1ps
module cacheCU(
    clk,
    rst,
    hit,

    cRead,
    cWrite,
    rRead,
    rWrite,
    selOut
);
input clk, rst, hit;
output reg cRead, cWrite, rRead, rWrite, selOut;

always @(posedge clk, posedge rst)begin
    if(rst) begin
        cRead = 1'b0;
        cWrite = 1'b0;
        rRead = 1'b0;
        rWrite = 1'b0;
    end
    else begin
        if(hit) begin 
            cRead = 1'b1;
            cWrite = 1'b0;
            rRead = 1'b0;
            rWrite = 1'b0;
            selOut = 1'b1;
        end
        else begin
            cRead = 1'b0;
            cWrite = 1'b1;
            rRead = 1'b1;
            rWrite = 1'b0;
            selOut = 1'b0;
        end
    end
end

endmodule
