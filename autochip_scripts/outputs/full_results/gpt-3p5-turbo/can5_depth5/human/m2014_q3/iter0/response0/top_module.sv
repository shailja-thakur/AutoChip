module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
	case(x)
		4'b00??: f = 1'b?; // don't care
		4'b01??: f = 1'b0; 
		4'b11??: f = 1'b1;
		4'b10??: f = 1'b?; // don't care
	endcase
end

endmodule
