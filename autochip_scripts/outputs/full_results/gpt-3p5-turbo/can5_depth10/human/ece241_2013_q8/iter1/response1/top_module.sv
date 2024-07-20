module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;
	
	reg [1:0] state;
	reg prev_x;
	reg detect;
	
	// State transition and output logic
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0;
		else begin
			case (state)
				S0: begin
					if (x && !prev_x) begin
						state <= S1;
						detect <= 0;
					end else begin
						state <= S0;
						detect <= 0;
					end
				end
				
				S1: begin
					if (x && prev_x) begin
						state <= S2;
						detect <= 1;
					end else begin
						state <= S0;
						detect <= 0;
					end
				end
				
				S2: begin
					if (!x && prev_x) begin
						state <= S0;
						detect <= 0;
					end else begin
						state <= S2;
						detect <= 0;
					end
				end
			endcase
		end
	end
	
	// Output assignment
	always @(posedge clk) begin
		if (aresetn == 0) begin
			z <= 0;
		end else if (detect) begin
			z <= 1;
		end else begin
			z <= 0;
		end
	end
	
	assign prev_x = x;
	
endmodule
