module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;
	
	always @(posedge clk) begin
		if(reset)
			state <= 3'b000;
		else if(state != 3'b11)
			state <= state + 1'b1;
		end	
	end
	
	assign shift_ena = (state == 3'b000 || state == 3'b001 || state == 3'b010 || state == 3'b011);
	
endmodule
