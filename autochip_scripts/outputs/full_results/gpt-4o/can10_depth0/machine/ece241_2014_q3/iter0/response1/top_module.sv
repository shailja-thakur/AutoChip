module top_module (
	input c,
	input d,
	output reg [3:0] mux_in
);

	always @(*) begin
		mux_in[0] = c | d;
		mux_in[1] = 0;
		mux_in[2] = ~d;
		mux_in[3] = c & d;
	end

endmodule
