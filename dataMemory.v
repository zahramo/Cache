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
    block3,
    memReady
    );

    parameter WORD = 32, LENGTH = 32768, ADDRESSL = 15, DELAY = 400;
    input [ADDRESSL-1:0]address, address0, address1, address2, address3;
    input [WORD-1:0]writeData;
    input memWrite,
    memRead,
    clk;
    output reg [WORD-1:0]dataOut;
    output reg [WORD-1:0]block0, block1, block2, block3;
    output reg memReady;
    reg [WORD-1:0]memory[LENGTH-1:0];

    integer i;
    reg [WORD-1:0]allData[2*LENGTH-1:0];
    initial begin
        // $readmemb("datas.txt", allData);
        for (i = 0; i < LENGTH; i = i + 1) begin
            memory[i] = i;
        end
        // for (i = 0; i < 2*LENGTH; i = i + 1) begin
        //     memory[allData[i][WORD-1:0]] = allData[i+1];
        //     i=i+1;
        // end
    end

    always @(posedge clk) begin
        if (memWrite)
            memory[address] <= writeData;
    end
    always @(*) begin
        memReady = 0;
        if (memRead) begin
            #(DELAY)
            dataOut = memory[address];
            block0 = memory[address0];
            block1 = memory[address1];
            block2 = memory[address2];
            block3 = memory[address3];
            memReady = 1;
        end
        else begin
            dataOut = {WORD*{1'bz}};
            block0 = {WORD*{1'bz}};
            block1 = {WORD*{1'bz}};
            block2 = {WORD*{1'bz}};
            block3 = {WORD*{1'bz}};
        end
    end
    
                      
endmodule
