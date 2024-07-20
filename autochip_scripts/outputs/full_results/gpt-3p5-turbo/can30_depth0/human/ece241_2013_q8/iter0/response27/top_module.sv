module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
	reg [1:0] state, next_state;
	
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= 2'b00;
			z <= 0;
		end else begin
			state <= next_state;
			z <= 0;
			case (state)
				0: begin
					if (x == 1'b1)
						next_state = 1;
					else
						next_state = 0;
				end
				1: begin
					if (x == 1'b0)
						next_state = 0;
					else
						next_state = 2;
				end
				2: begin
					if (x == 1'b1)
						next_state = 1;
					else
						next_state = 0;
				end
			endcase
		end
	end
	
	always @(state) begin
		if (state == 2)
			z <= 1;
	end
endmodule
