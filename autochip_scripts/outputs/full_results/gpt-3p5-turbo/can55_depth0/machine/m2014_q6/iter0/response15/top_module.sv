module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
wire next_state_high;
wire next_state_low;
wire clk_trigger;
wire reset_trigger;
wire next_state_trigger;

assign next_state_high = (state == 3'b000 && !w) || (state == 3'b001 && w) || (state == 3'b010 && w) || (state == 3'b100 && w) || (state == 3'b110 && w);
assign next_state_low = (state == 3'b001 && !w) || (state == 3'b010 && !w) || (state == 3'b011 && w) || (state == 3'b100 && !w) || (state == 3'b101 && w) || (state == 3'b110 && !w) || (state == 3'b111 && w);
assign clk_trigger = clk & !clk;
assign reset_trigger = reset & !reset;
assign next_state_trigger = clk_trigger | reset_trigger;

always @(posedge clk or posedge reset) begin
	if (reset_trigger) begin
		state <= 3'b000;
	end else if (clk_trigger) begin
		if (next_state_high) begin
			state <= state + 1;
		end else if (next_state_low) begin
			state <= state - 1;
		end
	end
end

assign z = (state == 3'b101 || state == 3'b111) ? 1'b1 : 1'b0;

endmodule
