module top_module (
	input [4:1] x,
	output logic f
);
	
	always_comb begin
		case (x)
			4'b00?? : f = 0;  // d is don't-care, choose to output 0
			4'b01?? : f = 0;  // d is don't-care, choose to output 0
			4'b10?? : f = 1;  // d is don't-care, choose to output 1
			4'b11?? : f = 1;  // d is don't-care, choose to output 1
			default: f = 0;  // default output is 0
		endcase
	end
	
endmodule
