module top_module (
	input [4:1] x,
	output logic f
);

always @(*) begin
    f = ( (~x[3] & ~x[4]) | // 0000, 0010
          ( x[3] & ~x[2] & ~x[1]) | // 1000
          ( x[4] & ~x[3]) | // 1010, 1001, 1011, 1110
          ( x[4] & x[3] & x[2]) // 1111
        );
end

endmodule
