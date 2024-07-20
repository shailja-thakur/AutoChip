module top_module(
	input clk,
	input rst,
	output reg out,
	output reg valid);

	reg [1:0] state;
	reg [7:0] counter;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			state <= 2'b00;
			counter <= 0;
			out <= 0;
			valid <= 0;
		end else begin
			case (state)
				2'b00: begin // Idle state
					counter <= 0;
					out <= 0;
					valid <= 0;
					if (in) begin
						state <= 2'b01; // Transition to wait state
					end
				end
			
				2'b01: begin // Wait state
					counter <= counter + 1;
					out <= 0;
					valid <= 0;
					if (counter == 8'hFF) begin
						state <= 2'b10; // Transition to process state
					end
				end
			
				2'b10: begin // Process state
					out <= in;
					state <= 2'b11; // Transition to done state
				end
			
				2'b11: begin // Done state
					out <= in;
					valid <= 1;
					state <= 2'b00; // Transition back to idle state
				end
			endcase
		end
	end
endmodule
