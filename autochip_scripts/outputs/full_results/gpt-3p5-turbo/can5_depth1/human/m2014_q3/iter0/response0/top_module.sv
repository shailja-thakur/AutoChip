module top_module (
	input [4:1] x,
	output logic f
);

// Define the truth table for the function f
always_comb begin
	case (x)
		4'b00??: f = 1; // Don't-care case, choose to output 1
		4'b01??:
			case (x[2:1])
				2'b00: f = 0;
				2'b01: f = 1;
				2'b11: f = 0;
				2'b10: f = 0;
			endcase
		4'b11??:
			case (x[2:1])
				2'b00: f = 1;
				2'b01: f = 1;
				2'b11: f = 1; // Don't-care case, choose to output 1
				2'b10: f = 1; // Don't-care case, choose to output 1
			endcase
		4'b10??:
			case (x[2:1])
				2'b00: f = 1;
				2'b01: f = 1;
				2'b11: f = 0;
				2'b10: f = 1; // Don't-care case, choose to output 1
			endcase
	endcase
end

endmodule
