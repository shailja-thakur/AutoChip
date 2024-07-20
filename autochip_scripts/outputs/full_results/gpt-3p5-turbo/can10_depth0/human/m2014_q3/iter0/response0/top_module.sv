module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
	case(x)
	    4'b0100: f = 0;
	    4'b0000, 4'b0010: f = x[1];
	    4'b0001: f = 1;
	    4'b0111, 4'b1000: f = x[2];
	    4'b1111: f = 1;
	    default: f = 0;
	endcase
end

endmodule
