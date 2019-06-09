`timescale 1ps/1ps
module cacheCU(
    clk,
    rst,
    hit,
    memReady,
    req,

    cRead,
    cWrite,
    rRead,
    rWrite,
    selOut,
    ready
    );
    input clk, rst, hit, memReady, req;
    output reg cRead, cWrite, rRead, rWrite, selOut, ready;

    reg [1:0] ps, ns;
    always @(posedge clk , posedge rst)begin
      if(rst) ps <= 4'b0;
      else ps <= ns;
    end

    always @(ps) begin
        cRead = 1'b0;
        cWrite = 1'b0;
        rRead = 1'b0;
        rWrite = 1'b0;
        selOut = 1'b1;
        ready = 1'b0;
        case(ps)
            2'b00: ready = 1;
            2'b01:begin
                    cRead = 1'b1;
                    selOut = 1'b1;
            end
            2'b10: begin 
                selOut = 1'b0;
                cWrite = 1'b1;
                rRead = 1'b1;
            end
            2'b11:begin 
            end
        endcase
    end

    always @(req, ps, hit, memReady)begin
        case(ps)
            2'b00:ns <= req && hit ? 2'b01 :
                    req && ~hit ? 2'b10 :
                    2'b00;
            2'b01:ns <= 2'b00;
            2'b10:ns <= memReady ? 2'b11 :
                        2'b10;
            2'b11:ns <= 2'b00;
            default:ns <= ns;
        endcase
    end

endmodule
