module top_module (
	input [4:1] x,
	output logic f
);

// Define the truth table for function f
// MSB: x[4], ... , LSB: x[1]
assign f = ((x[3] == 0) && (x[4] == 0)) ||
          ((x[3] == 0) && (x[4] == 1)) ||
          ((x[3] == 1) && (x[4] == 1) && (x[1] == 1) && (x[2] == 1)) ||
          ((x[3] == 1) && (x[4] == 1) && (x[1] == 0) && (x[2] == 0)) ||
          ((x[3] == 1) && (x[4] == 1) && (x[1] == 0) && (x[2] == 1));

endmodule
