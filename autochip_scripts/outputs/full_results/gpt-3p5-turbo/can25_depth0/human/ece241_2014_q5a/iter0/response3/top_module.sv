module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
	
	reg state;
	reg [2:0] count;
	
	// State Definitions
	parameter S_RESET = 0;
	parameter S_IDLE = 1;
	parameter S_COMPLEMENT = 2;
	
	always @(posedge clk or negedge areset) begin
		if (areset == 0) begin
			state <= S_RESET;
			count <= 0;
			z <= 0;
		end else begin
			case(state)
				S_RESET:
					if (areset == 1)
						state <= S_IDLE;
				S_IDLE:
					if (x == 1 && count == 0)
						state <= S_COMPLEMENT;
				S_COMPLEMENT:
					if (count < 3)
						state <= S_COMPLEMENT;
					else
						state <= S_IDLE;
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (areset == 0) begin
			count <= 0;
			z <= 0;
		end else begin
			case(state)
				S_RESET:
					count <= 0;
					z <= 0;
				S_IDLE:
					if (x == 1 && count == 0)
						count <= 3;
					else
						count <= count;
				S_COMPLEMENT:
					count <= count + 1;
					z <= ~(z << 1);
			endcase
		end
	end
endmodule
