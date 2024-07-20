module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	
	reg [1:0] current_state;
	reg [1:0] next_state;
	
	always @ (j, current_state)
		begin
			if (current_state == 2'b00)
				next_state = j ? 2'b01 : 2'b00;
			else if (current_state == 2'b01)
				next_state = k ? 2'b00 : 2'b01;
		end
	
	always @(posedge clk, areset)
		begin
			if (areset)
				current_state <= 2'b00;
			else
				current_state <= next_state;
		end
	
	assign out = (current_state == 2'b01) ? 1'b1 : 1'b0;
	
endmodule
