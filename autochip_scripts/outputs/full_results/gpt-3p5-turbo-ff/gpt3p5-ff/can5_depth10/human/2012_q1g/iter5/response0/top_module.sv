module top_module (
	input [4:1] x,
	output logic f
);

// Implementing the function f using the given Karnaugh map
assign f = (~x[3] & ~x[2] & ~x[1]) |
          (~x[3] & ~x[2] & x[1]) |
          (~x[3] & x[2] & ~x[1]) |
          (x[3] & ~x[2] & ~x[1]) |
          (x[3] & x[2] & ~x[1]) |
          (x[3] & x[2] & x[1]);

endmodule
