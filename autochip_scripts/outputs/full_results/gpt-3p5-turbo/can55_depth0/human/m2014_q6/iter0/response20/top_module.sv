module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state, next_state;
reg z_out;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
		z_out <= 0;
	end
	else begin
		state <= next_state;
		z_out <= (state == F) ? 1'b1 : 1'b0;
	end
end

always @(state, w) begin
	case (state)
		A: if (w) next_state = A; else next_state = B;
		B: if (w) next_state = D; else next_state = C;
		C: if (w) next_state = D; else next_state = E;
		D: if (w) next_state = A; else next_state = F;
		E: if (w) next_state = D; else next_state = E;
		F: if (w) next_state = D; else next_state = C;
		default: next_state = A;
	endcase
end

assign z = z_out;

endmodule
