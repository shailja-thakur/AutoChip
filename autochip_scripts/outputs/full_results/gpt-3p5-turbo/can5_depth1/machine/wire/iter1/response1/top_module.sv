module top_module(
	input clk,
	input reset,
	input in,
	output reg data_output,
	output reg valid_output);

	reg [1:0] state;
	reg [7:0] counter;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00;
			counter <= 8'b00000000;
			data_output <= 1'b0;
			valid_output <= 1'b0;
		end
		else begin
			case (state)
				2'b00: begin
					counter <= counter + 1;
					data_output <= 1'b0;
					valid_output <= 1'b0;
					
					if (counter >= 8'd10) begin
						counter <= 8'b00000000;
						state <= 2'b01;
					end
				end
				
				2'b01: begin
					data_output <= in;
					valid_output <= 1'b1;
					state <= 2'b10;
				end
				
				2'b10: begin
					valid_output <= 1'b1;
					state <= 2'b00;
				end
			endcase
		end
	end
	
endmodule
