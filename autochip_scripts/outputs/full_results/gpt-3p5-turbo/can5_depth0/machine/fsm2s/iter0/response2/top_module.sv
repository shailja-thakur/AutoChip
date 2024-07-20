module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

reg [1:0] state, next_state;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
		out <= 0;
	end else begin
		state <= next_state;
		out <= (state == B) ? 1 : 0;
	end
end

always @(state, j, k) begin
	case (state)
		A: begin
			next_state = (j) ? B : A;
		end
		B: begin
			next_state = (k) ? A : B;
		end
	endcase
end

endmodule
