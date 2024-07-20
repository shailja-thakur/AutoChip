module top_module(
	input wire clk,
  input wire reset,
	output reg [31:0] data_out,
	output reg valid_out
	);
	
	reg [1:0] state;
	reg [7:0] counter;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00; // idle state
			counter <= 0;
			data_out <= 0;
			valid_out <= 0;
		end else begin
			case (state)
				2'b00: begin // idle state
					counter <= 0;
					data_out <= 0;
					valid_out <= 0;
					if (in) begin
						state <= 2'b01; // wait state
					end
				end
				2'b01: begin // wait state
					counter <= counter + 1;
					data_out <= 0;
					valid_out <= 0;
					if (counter == 8) begin
						state <= 2'b10; // process state
					end
				end
				2'b10: begin // process state
					counter <= 0;
					data_out <= in;
					valid_out <= 1;
					state <= 2'b11; // done state
				end
				2'b11: begin // done state
					counter <= 0;
					data_out <= 0;
					valid_out <= 1;
					if (reset) begin
						state <= 2'b00; // idle state
					end
				end
			endcase
		end
	end
endmodule
