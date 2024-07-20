module top_module (
	input [4:1] x,
	output logic f
);

// Implementing function f using a case statement
always_comb begin
	case (x)
		4'b0000: f = 1;
		4'b0001: f = 0;
		4'b001x: f = x[2];
		4'b01x0: f = 1;
		4'b01x1: f = 0;
		4'b010x: f = x[1];
		default: f = 0;
	endcase
end

endmodule
