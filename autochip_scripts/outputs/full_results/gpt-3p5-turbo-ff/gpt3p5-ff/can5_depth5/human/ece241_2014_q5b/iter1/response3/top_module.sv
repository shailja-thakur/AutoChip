module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	reg [1:0] state;
	reg [1:0] next_state;
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b00;
		else
			state <= next_state;
	end
	
	always @* begin
		case(state)
			2'b00: next_state = x ? 2'b01 : 2'b00;
			2'b01: next_state = x ? 2'b00 : 2'b01;
			default: next_state = state;
		endcase
	end
	
	assign z = (state == 2'b01) ? 1'b1 : 1'b0;
	
endmodule
