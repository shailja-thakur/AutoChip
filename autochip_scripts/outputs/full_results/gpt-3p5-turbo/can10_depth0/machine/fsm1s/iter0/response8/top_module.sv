module top_module (
	input clk,
	input in,
	input reset,
	output out
);

parameter A = 0;
parameter B = 1;

reg state;
reg next_state;

always @ (posedge clk) begin
	if (reset == 1'b1) begin
		state <= B;
	end else begin
		state <= next_state;
	end
end

always @ (*) begin
	case (state)
		A: begin
			if (in == 1'b1) begin
				next_state = A;
			end else begin
				next_state = B;
			end
		end
		B: begin
			if (in == 1'b1) begin
				next_state = B;
			end else begin
				next_state = A;
			end
		end
		default: next_state = B;
	endcase
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
