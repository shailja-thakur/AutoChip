module top_module (
	input [4:1] x,
	output logic f
);

// Implementing the function f using a case statement
always_comb begin
	case(x)
		4'b0001: f = 1'b1;
		4'b0011: f = 1'b0;
		4'b0111: f = 1'b0;
		4'b1000: f = 1'b1;
		4'b1001: f = 1'b1;
		default: f = 1'b0;
	endcase
end

endmodule
