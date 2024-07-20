module top_module(
	input clk,
	input reset,
	output reg data_output,
	output reg valid_output);

	reg [1:0] state;
	reg [7:0] counter;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= idle;
			counter <= 0;
			data_output <= 0;
			valid_output <= 0;
		end
		else begin
			case (state)
				idle: begin
					counter <= 0;
					data_output <= 0;
					valid_output <= 0;
					state <= wait;
				end
				
				wait: begin
					counter <= counter + 1;
					data_output <= 0;
					valid_output <= 0;
					
					if (counter >= 10) begin
						counter <= 0;
						state <= process;
					end
				end
				
				process: begin
					data_output <= in;
					valid_output <= 1;
					state <= done;
				end
				
				done: begin
					valid_output <= 1;
					state <= idle;
				end
			endcase
		end
	end

endmodule
