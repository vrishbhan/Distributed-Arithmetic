//*****************************************************************//
// Testbench for Distributed Arithmetic 
// Created By - Vrishbhan Singh Sisodia
// San Jose State University
// EE 278
//*****************************************************************//
module tb;
reg clk_80,rst_80;

reg [3:0] x_in_80;
wire [5:0] y_out_80;

initial begin
	x_in_80 = 4'b0000;
	#10;
	x_in_80 = 4'b1011;
	#10;
	x_in_80 = 4'b0101;
	#10;
	x_in_80 = 4'b1111;
	#10;
	x_in_80 = 4'b0110;
	#10;
	x_in_80 = 4'b1110;
	#10;
	x_in_80 = 4'b0110;
	#10;
	x_in_80 = 4'b1110;
	#10;
	x_in_80 = 4'b011;
	#100;
	$finish;
end

da d1(clk_80,  rst_80, x_in_80, y_out_80);

initial begin
	clk_80 = 1;
	repeat (1000) clk_80 = #5 ~clk_80;
	$finish;
end

initial begin
	rst_80 = 1;
	#10;
	rst_80 = 0;
end


endmodule