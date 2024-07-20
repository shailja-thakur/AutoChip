module top_module(
	input wire clk,
	input wire reset,
	output reg out,
	output reg valid);
	
	reg [1:0] state;
	reg [7:0] counter;
	reg [7:0] data;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= 0;
			counter <= 0;
			data <= 0;
			valid <= 0;
		end else begin
			case (state)
				0: begin // idle state
					counter <= 0;
					data <= 0;
					valid <= 0;
					
					if (in == 1'b1) begin
						state <= 1; // transition to wait state
					end
				end
				
				1: begin // wait state
					counter <= counter + 1;
					data <= 0;
					valid <= 0;
					
					if (counter >= 8'hFF) begin
						state <= 2; // transition to process state
					end
				end
				
				2: begin // process state
					data <= in;
					state <= 3; // transition to done state
				end
				
				3: begin // done state
					valid <= 1;
					state <= 0; // transition back to idle state
				end
			endcase
		end
	end
	
	assign out = data;
endmodule
