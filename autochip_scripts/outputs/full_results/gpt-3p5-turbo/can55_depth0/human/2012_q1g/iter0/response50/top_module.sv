module top_module (
	input [4:1] x,
	output logic f
);

// Implementing the function f using the given truth table

always_comb begin
	case (x)
		4'b 0000 : f = 1'b1;
		4'b 0001 : f = 1'b0;
		4'b 0011 : f = 1'b1;
		4'b 0100 : f = 1'b1;
		4'b 0101 : f = 1'b0;
		4'b 0111 : f = 1'b1;
		4'b 1000 : f = 1'b0;
		4'b 1001 : f = 1'b0;
		4'b 1011 : f = 1'b0;
		4'b 1100 : f = 1'b0;
		4'b 1101 : f = 1'b1;
		4'b 1111 : f = 1'b0;
		default : f = 1'b0;
	endcase
end

endmodule
