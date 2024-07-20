module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

reg [1:0] state, next_state;

localparam [1:0] 
	A = 2'b00,
	B = 2'b01,
	C = 2'b10,
	D = 2'b11;

always @(posedge clk) begin
	if (reset)
		state <= A;
	else
		state <= next_state;
end

always @(*) begin
	case (state)
		A:
			if (in) begin
				next_state = B;
				out = 1'b0;
			end else begin
				next_state = A;
				out = 1'b0;
			end
		B:
			if (in) begin
				next_state = B;
				out = 1'b0;
			end else begin
				next_state = C;
				out = 1'b0;
			end
		C:
			if (in) begin
				next_state = D;
				out = 1'b0;
			end else begin
				next_state = A;
				out = 1'b0;
			end
		D:
			if (in) begin
				next_state = B;
				out = 1'b1;
			end else begin
				next_state = C;
				out = 1'b1;
			end
		default:
			begin
				next_state = A;
				out = 1'b0;
			end
	endcase
end

endmodule
