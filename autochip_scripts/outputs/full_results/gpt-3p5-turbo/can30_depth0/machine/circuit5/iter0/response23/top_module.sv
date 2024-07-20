module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

	reg [3:0] q_tmp;

	always @(c) begin
		case(c)
			2'b00: q_tmp <= b;
			2'b01: q_tmp <= e;
			2'b10: q_tmp <= a;
			2'b11: q_tmp <= d;
			default: q_tmp <= 4'hf;
		endcase
	end

	always @(posedge clk or negedge rst) begin
		if (!rst)
			q <= 4'h0;
		else
			q <= q_tmp;
	end

endmodule
