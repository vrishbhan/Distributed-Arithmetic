//*****************************************************************//
// Top Module for Distributed Arithmetic Calculation
// Created By - Vrishbhan Singh Sisodia
// San Jose State University
// EE 278
//*****************************************************************//
module da (clk_80,  rst_80, x_in_80, y_out_80);
	input clk_80,rst_80;
	input [3:0] x_in_80;
	output [5:0] y_out_80;
	
	reg [3:0] x0_80, x1_80, x2_80, x3_80, x4_80, x5_80; 
	wire [5:0] a0,a1,a2,a3;
	reg [5:0] y_out_80;
	wire cout0_80, cout1_80, cout2_80, cout00_80, oflow00_80, oflow0_80, oflow1_80, oflow2_80;
	wire [6:0] result0_80, result1_80, a3_comp_80, a3_sat_80;
	wire [6:0] sat_result0_80, sat_result1_80;
	wire [8:0] result2_80, sat_result2_80;
	wire [5:0] y_rounded_80; 
	
	always @(posedge clk_80 or posedge rst_80)
	begin
		if (rst_80) begin
			x0_80 <= 0;
			x1_80 <= 0;
			x2_80 <= 0;
			x3_80 <= 0;
			x4_80 <= 0;
			x5_80 <= 0;
		end
		else begin
			x0_80 <= x_in_80;
			x1_80 <= x0_80;
			x2_80 <= x1_80;
			x3_80 <= x2_80;
			x4_80 <= x3_80;
			x5_80 <= x4_80;
		end
	end
	
	//LookUp Table
	lut l3 (.in_80({x5_80[3],x4_80[3],x3_80[3],x2_80[3],x1_80[3],x0_80[3]}),.out_80(a3));
	lut l2 (.in_80({x5_80[2],x4_80[2],x3_80[2],x2_80[2],x1_80[2],x0_80[2]}),.out_80(a2));
	lut l1 (.in_80({x5_80[1],x4_80[1],x3_80[1],x2_80[1],x1_80[1],x0_80[1]}),.out_80(a1));
	lut l0 (.in_80({x5_80[0],x4_80[0],x3_80[0],x2_80[0],x1_80[0],x0_80[0]}),.out_80(a0));
	
	add a_1 (.dataa({a1,1'b0}), .datab({{a0[5]},a0}), .cout(cout0_80), .overflow(oflow0_80), .result(result0_80));	
	add a_00 (.dataa({~a3[5:0],1'b1}), .datab({7'b1}), .cout(cout00_80), .overflow(oflow00_80), .result(a3_comp_80));
	add a_2 (.dataa(a3_sat_80), .datab({{a2[5]},a2}), .cout(cout1_80), .overflow(oflow1_80), .result(result1_80));
	add9 a (.dataa({sat_result1_80,2'b00}), .datab({{2{sat_result0_80[6]}},sat_result0_80}), .cout(cout2_80), .overflow(oflow2_80), .result(result2_80));
	
	//Saturation Logic
	saturation_logic s0 ( .sum_saturated_80(sat_result0_80), .sum_80(result0_80), .carry_80(cout0_80), .oflow_80(oflow0_80) );
	saturation_logic s00 ( .sum_saturated_80(a3_sat_80), .sum_80({(rst_80)?7'b0:a3_comp_80}), .carry_80(cout00_80), .oflow_80(oflow00_80) );
	saturation_logic s1 ( .sum_saturated_80(sat_result1_80), .sum_80(result1_80), .carry_80(cout1_80), .oflow_80(oflow1_80) );
	saturation_logic s2 ( .sum_saturated_80(sat_result2_80), .sum_80(result2_80), .carry_80(cout2_80), .oflow_80(oflow2_80) );

	defparam
		s0.WIDTH_SUM = 7;
	defparam
		s00.WIDTH_SUM = 7;
	defparam
		s1.WIDTH_SUM = 7;
	defparam
		s2.WIDTH_SUM = 9;
		
	rounding_logic r1( .prod_rounded_80(y_rounded_80), .prod_80(sat_result2_80) );
	
	defparam
		 r1.WIDTH_PROD = 9,
		 r1.WIDTH_PROD_ROUNDED = 6;
	always @(posedge clk_80 or posedge rst_80)
	begin
		if (rst_80) begin
			y_out_80 <= 0;
		end
		else begin
			y_out_80 <= y_rounded_80;
		end
	end
	
endmodule