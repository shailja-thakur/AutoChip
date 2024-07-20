module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state, next_state;
	always @(posedge clk, posedge areset) begin
		if (areset) begin
			state <= 2'b01; // set state to B on reset
		end else begin
			state <= next_state;
		end
	end

	always @(state, in) begin
		case (state)
			2'b00: next_state = in ? 2'b00 : 2'b01; // A
			2'b01: next_state = in ? 2'b01 : 2'b00; // B
		endcase
	end

	assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
