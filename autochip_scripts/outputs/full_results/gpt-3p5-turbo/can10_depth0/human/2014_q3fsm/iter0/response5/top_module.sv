module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	
	reg [1:0] state;
	reg [1:0] next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;
		else
			state <= next_state;
	end
	
	always @(state or w) begin
		case (state)
			2'b00: begin
				if (s == 1)
					next_state = 2'b01;
				else
					next_state = 2'b00;
			end
			
			2'b01: begin
				if (w == 1)
					next_state = 2'b10;
				else
					next_state = 2'b01;
			end
			
			2'b10: begin
				if (w == 1)
					next_state = 2'b11;
				else
					next_state = 2'b01;
			end
			
			2'b11: begin
				if (w == 1)
					z <= 1;
				else
					z <= 0;
				
				next_state = 2'b01;
			end
		endcase
	end
endmodule
