module top_module (
	input [4:1] x,
	output logic f
);

// Define the truth table for the function f
always_comb begin
	case (x)
		4'b00x0 : f = 1;    // x[3]=0, x[4]=don't care
		4'b01xx : f = 0;    // x[3]=1, x[4]=don't care
		4'b11x0 : f = 1;    // x[3]=don't care, x[4]=0
		4'b11x1 : f = 1;    // x[3]=don't care, x[4]=1
		4'b1xxx : f = 0;    // x[3]=don't care, x[4]=don't care
		4'b10x1 : f = 1;    // x[3]=1, x[4]=don't care
		default : f = 0;    // All other cases
	endcase
end

endmodule
