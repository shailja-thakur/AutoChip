module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting
);

	reg [3:0] state;
	reg [2:0] cnt;
	wire [3:0] next_state;
	assign next_state = (state << 1) | data;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0000;
		end else begin
			state <= next_state;
			if (state == 4'b1101) begin
				start_shifting <= 1;
			end else begin
				start_shifting <= 0;
			end
		end
	end

endmodule
