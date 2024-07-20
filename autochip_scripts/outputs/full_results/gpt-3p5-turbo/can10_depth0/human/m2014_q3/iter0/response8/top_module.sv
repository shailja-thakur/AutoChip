module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
	case(x)
		4'b0000: f = d; // Choose any convenient value for don't-care inputs
		4'b0001: f = 0;
		4'b0010: f = d;
		4'b0011: f = 1;
		4'b1000: f = d;
		4'b1001: f = 1;
		4'b1010: f = 1;
		4'b1011: f = 0;
		4'b1100: f = d;
		default: f = d;
	endcase
end

endmodule
