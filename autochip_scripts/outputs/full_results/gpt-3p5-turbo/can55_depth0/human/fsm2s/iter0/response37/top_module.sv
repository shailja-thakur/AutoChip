module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;
		else if (state == 2'b00)
			state <= j ? 2'b01 : 2'b00;
		else if (state == 2'b01)
			state <= k ? 2'b00 : 2'b01;
	end

	always @(state) begin
		case (state)
			2'b00: out = 1'b0;
			2'b01: out = 1'b1;
		endcase
	end

endmodule
