`timescale 1ns / 1ps

module tb_Computer();

    reg reset;
    reg [7:0] ins_addr;
    reg [31:0] ins;
    reg clk;
    reg done_storing;

    wire done;
    wire [31:0] out_reg1;
    wire [31:0] out_reg2;
    wire [31:0] out_reg3;
    wire [31:0] out_reg4;
    wire [31:0] total_cycles;
    wire [31:0] proc_cycles;

    Computer uut (
        .reset(reset), 
        .ins_addr(ins_addr), 
        .ins(ins), 
        .clk(clk), 
        .done_storing(done_storing), 
        .done(done), 
        .out_reg1(out_reg1), 
        .out_reg2(out_reg2), 
        .out_reg3(out_reg3), 
        .out_reg4(out_reg4), 
        .total_cycles(total_cycles), 
        .proc_cycles(proc_cycles)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        done_storing = 0;
        ins_addr = 0;
        ins = 0;

        #7;
        reset = 0;
        
        ins_addr = 8'd0;   
        ins = 32'h20010019; 

        #10;
        ins_addr = 8'd1;   
        ins = 32'h2002000f; 

        #10;
        ins_addr = 8'd2;
        ins = 32'h00221822; 

        #10;
        ins_addr = 8'd3;
        ins = 32'h00032080; 

        #10;
        ins_addr = 8'd4;
        ins = 32'h00812826; 

        #10;
        ins_addr = 8'd5;
        ins = 32'h200603ec; 

        #10;
        ins_addr = 8'd6;   
        ins = 32'h00c5000c; 

        #10;
        ins_addr = 8'd7;   
        ins = 32'h200603e9; 

        #10;
        ins_addr = 8'd8;   
        ins = 32'h00c0000c;

        #10;
        done_storing = 1;

        wait(done == 1'b1);
        #10;

        $display("-------------------------------------------------");
        $display("Test Execution Complete!");
        $display("Total Cycles = %0d", total_cycles);
        $display("Processor Computation Cycles = %0d", proc_cycles);
        $display("-------------------------------------------------");

        $finish;
    end
      
endmodule
