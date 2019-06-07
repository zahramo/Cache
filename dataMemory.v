`timescale 1ps/1ps
module DataMemory (
    clk,
    address,
    address0,
    address1,
    address2,
    address3,
    memWrite,
    memRead,
    
    writeData,
    dataOut,
    block0, 
    block1, 
    block2, 
    block3
    );

    parameter WORD = 32, LENGTH = 32768, ADDRESSL = 15;
    input [ADDRESSL-1:0]address, address0, address1, address2, address3;
    input [WORD-1:0]writeData;
    input memWrite,
    memRead,
    clk;
    output [WORD-1:0]dataOut;
    output [WORD-1:0]block0, block1, block2, block3;
    reg [WORD-1:0]memory[LENGTH-1:0];

    integer i;
    reg [WORD-1:0]allData[2*LENGTH-1:0];
    initial begin
        $readmemb("datas.txt", allData);
        for (i = 0; i < LENGTH; i = i + 1) begin
            memory[i] = 0;
        end
        for (i = 0; i < 2*LENGTH; i = i + 1) begin
            memory[allData[i][WORD-1:0]] = allData[i+1];
            i=i+1;
        end
    end

    always @(posedge clk) begin
        if (memWrite)
            memory[address] <= writeData;
    end
    assign dataOut = memRead ? memory[address] : {WORD*{1'bz}};
    assign block0 = memRead ? memory[address0] : {WORD*{1'bz}};
    assign block1 = memRead ? memory[address1] : {WORD*{1'bz}};
    assign block2 = memRead ? memory[address2] : {WORD*{1'bz}};
    assign block3 = memRead ? memory[address3] : {WORD*{1'bz}};
                      
endmodule
