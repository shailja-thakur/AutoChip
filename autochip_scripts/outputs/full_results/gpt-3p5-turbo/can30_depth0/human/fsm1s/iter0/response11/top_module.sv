module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b0;
		else if (state == 2'b00)
			state <= (in == 1'b0) ? 2'b10 : 2'b00;
		else
			state <= (in == 1'b0) ? 2'b00 : 2'b10;
	end

	always @(state) begin
		case (state)
			2'b00: out <= 1'b1;
			2'b10: out <= 1'b0;
		endcase
	end
endmodule
