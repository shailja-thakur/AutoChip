module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	reg [1:0] state, next_state;
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b00;
		else
			state <= next_state;
	end

	always @(state, j, k) begin
		case (state)
			2'b00: next_state = (j) ? 2'b01 : 2'b00;
			2'b01: next_state = (k) ? 2'b00 : 2'b01;
		endcase
	end

	assign out = (state == 2'b01) ? 1'b1 : 1'b0;
endmodule
