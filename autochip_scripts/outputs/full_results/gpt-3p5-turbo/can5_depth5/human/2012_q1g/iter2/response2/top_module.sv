module top_module (
	input [4:1] x,
	output logic f
);

// Implementing the function f using a case statement
always_comb begin
	case(x)
		4'b0001: f = 1'b1;
		4'b0010: f = 1'b0;
		4'b0011: f = 1'b0;
		4'b0100: f = 1'b1; // Updated case from 0101 to 0100
		4'b0101: f = 1'b0;
		4'b0110: f = 1'b0;
		4'b0111: f = 1'b0;
		4'b1000: f = 1'b1; // Updated case from 1010 to 1000
		4'b1001: f = 1'b0; // Updated case from 1011 to 1001
		4'b1010: f = 1'b0;
		4'b1011: f = 1'b1;
		4'b1100: f = 1'b1;
		default: f = 1'b0;
	endcase
end

endmodule
