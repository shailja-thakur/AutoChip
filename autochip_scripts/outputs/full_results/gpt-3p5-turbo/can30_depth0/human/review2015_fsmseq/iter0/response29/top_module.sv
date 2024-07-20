module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Define states
	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;
	parameter S3 = 2'b11;
	
	reg [1:0] state;
	reg start_shifting;
	reg last_data;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S0;
			start_shifting <= 0;
			last_data <= 0;
		end else begin
			last_data <= data;
			
			case (state)
				S0: begin
					if (data)
						state <= S1;
					else
						state <= S0;
				end
				
				S1: begin
					if (data)
						state <= S2;
					else
						state <= S0;
				end
				
				S2: begin
					if (data)
						state <= S3;
					else
						state <= S0;
				end
				
				S3: begin
					if (data)
						state <= S3;
					else
						state <= S0;
					
					if (last_data && !start_shifting)
						start_shifting <= 1;
				end
			endcase
		end
	end
	
endmodule
