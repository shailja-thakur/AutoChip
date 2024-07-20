module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

// Define Y0 using a case statement
always_comb begin
	case ({y[2:0], x})
		4'h0: Y0 = 0;
		4'h1: Y0 = 1;
		4'h2: Y0 = 1;
		4'h3: Y0 = 0;
		4'h4: Y0 = 0;
		4'h5: Y0 = 1;
		4'h6: Y0 = 1;
		4'h7: Y0 = 0;
		default: Y0 = x;
	endcase
end

// Define z using a case statement
always_comb begin
	case (y[2:0])
		3'h0: z = 0;
		3'h1: z = 0;
		3'h2: z = 0;
		3'h3: z = 1;
		default: z = x;
	endcase
end

endmodule
