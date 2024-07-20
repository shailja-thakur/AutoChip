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
	reg [2:0] seq_count;
	
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0;
		else begin
			case (state)
				S0: begin
					if (x)
						state <= S1;
				end
				
				S1: begin
					if (x)
						state <= S2;
				end
				
				S2: begin
					if (!x)
						state <= S0;
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (!aresetn)
			seq_count <= 3'b0;
		else begin
			case (state)
				S0: begin
					seq_count <= 3'b0;
				end
				
				S1: begin
					if (seq_count < 3'b101)
						seq_count <= seq_count + 1;
					else
						seq_count <= 3'b0;
				end
				
				S2: begin
					if (seq_count >= 3'b101)
						seq_count <= 3'b0;
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (state == S2 && seq_count >= 3'b101)
			z <= 1'b1;
		else
			z <= 1'b0;
	end
	
endmodule
