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
	reg [2:0] sequence_check;
	
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0;
		else begin
			case (state)
				S0: begin
					if (x && !prev_x) begin
						sequence_check <= {sequence_check[1:0], 1'b1};
						if (sequence_check == 3'b101)
							state <= S2;
						else
							state <= S1;
					end
					else
						state <= S0;
				end
				
				S1: begin
					if (x && !prev_x) begin
						sequence_check <= {sequence_check[1:0], 1'b1};
						if (sequence_check == 3'b101)
							state <= S2;
					end
					else if (!x) begin
						sequence_check <= {sequence_check[1:0], 1'b0};
						state <= S0;
					end
				end
				
				S2: begin
					if (!x && prev_x) begin
						sequence_check <= {sequence_check[1:0], 1'b0};
						state <= S0;
					end
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
