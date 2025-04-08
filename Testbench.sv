// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module Vending_machine_tb;

    // Tạo tín hiệu cho testbench
    logic clk;
    logic rs;
    logic nickle, dime, quarter;
    logic s;
    logic [2:0] c;

    // Tạo instance của Vending_machine
    Vending_machine dut (
        .clk(clk),
        .rs(rs),
        .nickle(nickle),
      .dime(dime),
        .quarter(quarter),
        .s(s),
        .c(c)
    );

    always #5 clk = ~clk;

    // Test sequence
    initial begin
        $dumpfile("Vending_machine_tb.vcd");
        $dumpvars(0, Vending_machine_tb);
        
        clk = 0;
        rs = 0;
        nickle = 0;
        dime = 0;
        quarter = 0;

        // Reset hệ thống
        #10 rs = 1;

        #10 nickle = 1;  
        #10 nickle = 0;

        #10 dime = 1; 
        #10 dime = 0;
      
		    #10 rs = 0;
        #10 rs = 1;
      
        #10 quarter = 1;  
        #10 quarter = 0;

        #10 quarter = 1;  
        #10 quarter = 0;
		
      	#10 dime = 1;
      	#20 dime = 0;
        #20;
        
        rs = 0;
        #10 rs = 1;
        
        #20;
        $finish;
    end
endmodule
