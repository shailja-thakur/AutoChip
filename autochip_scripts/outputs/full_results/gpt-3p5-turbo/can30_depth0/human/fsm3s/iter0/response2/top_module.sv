module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg next_state;
reg out;

parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter D = 3;

always @(posedge clk, posedge reset) begin
	if (reset) begin
		state <= A;
	else begin
		state <= next_state;
	end
end

always @(state or in) begin
	case(state)
		A: begin
			if (in) begin
				next_state = B;
			end else begin
				next_state = A;
			end
			out = 0;
		end
		B: begin
			if (in) begin
				next_state = B;
			end else begin
				next_state = C;
			end
			out = 0;
		end
		C: begin
			if (in) begin
				next_state = D;
			end else begin
				next_state = A;
			end
			out = 0;
		end
		D: begin
			if (in) begin
				next_state = B;
			end else begin
				next_state = C;
			end
			out = 1;
		end
	endcase
end

assign out = out;

endmodule
