module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	reg [1:0] state;
	reg prev_x;

	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0;
		else begin
			case (state)
				S0: begin
					if (x && !prev_x)
						state <= S1;
				end

				S1: begin
					if (!x && prev_x) // Changed condition from x && !prev_x to !x && prev_x
						state <= S2;
					else if (x && !prev_x)
						state <= S1;
				end

				S2: begin
					if (x && !prev_x)
						state <= S1; // Changed state from S0 to S1
				end
			endcase
		end
	end
	
	always @(state) begin
		if (state == S2)
			z <= 1'b1;
		else
			z <= 1'b0;
	end
	
	assign prev_x = x;
	
endmodule
