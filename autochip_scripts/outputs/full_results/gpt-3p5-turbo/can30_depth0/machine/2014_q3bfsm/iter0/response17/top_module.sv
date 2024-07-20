module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);
	reg [2:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'd0;
		else
			case (state)
				3'd0: state <= x ? 3'd1 : 3'd0;
				3'd1: state <= x ? 3'd4 : 3'd1;
				3'd2: state <= x ? 3'd1 : 3'd2;
				3'd3: state <= x ? 3'd2 : 3'd3;
				3'd4: state <= x ? 3'd3 : 3'd4;
				default: state <= 3'd0;
			endcase
	end

	always @(posedge clk) begin
		z <= (state == 3'd3) || (state == 3'd4);
	end
endmodule
