module top_module (
	input clk,
	input in,
	input reset,
	output out
);
reg [1:0] state;
	
always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 2'b10; // reset state B
	else if(state == 2'b10) begin
		if(in)
			state <= 2'b10; // stay in state B
		else
			state <= 2'b01; // transition to state A
	end else if(state == 2'b01) begin
		if(in)
			state <= 2'b01; // stay in state A
		else
			state <= 2'b10; // transition to state B
	end
end
	
assign out = (state == 2'b01) ? 1'b0 : 1'b1;
	
endmodule
