module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	reg [1:0] state, next_state;
	
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= 2'b00;
		else
			state <= next_state;
	end
	
	always @*
	begin
		next_state = state;
		case(state)
			2'b00: begin
				if (j)
					next_state = 2'b01;
			end
			2'b01: begin
				if (k)
					next_state = 2'b00;
			end
		endcase
	end
	
	always @*
	begin
		case(state)
			2'b00: out = 1'b0;
			2'b01: out = 1'b1;
		endcase
	end
endmodule
