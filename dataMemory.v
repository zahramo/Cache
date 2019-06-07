`timescale 1ps/1ps
module DataMemory (
    address,
    writeData,
    readData,
    memWrite,
    memRead,
    clk
    );
    parameter WORD = 32, LENGTH = 4000, ADDRESSL = 32;
    input [ADDRESSL-1:0]address;
    input [WORD-1:0]writeData;
    input memWrite,
    memRead,
    clk;
    output  [WORD-1:0]readData;
    reg [WORD-1:0]memory[LENGTH-1:0];

    integer i;
    reg [WORD-1:0]allData[2*LENGTH-1:0];
    initial begin
        $readmemb("datas.txt", allData);
        for (i = 0; i < LENGTH; i = i + 1) begin
            memory[i] = 0;
        end
        for (i = 0; i < 2*LENGTH; i = i + 1) begin
            memory[allData[i][31:0]] = allData[i+1];
            i=i+1;
        end
    end

    always @(posedge clk) begin
        if (memWrite)
            memory[address] <= writeData;
    end
    assign readData = memRead ? memory[address] : readData;
                      
endmodule
