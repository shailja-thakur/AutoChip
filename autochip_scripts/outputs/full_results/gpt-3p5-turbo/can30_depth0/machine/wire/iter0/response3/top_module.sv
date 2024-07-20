module top_module(
	input clk,
	input rst,
	output reg data_out,
	output reg valid);

	reg [1:0] state;
	reg [7:0] counter;
	reg [7:0] data;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			state <= 2'b00;
			counter <= 8'b0;
			data_out <= 8'b0;
			valid <= 1'b0;
		end else begin
			case (state)
				2'b00: begin // idle state
					counter <= 8'b0;
					data_out <= 8'b0;
					state <= 2'b01;
				end
				2'b01: begin // wait state
					counter <= counter + 1;
					data_out <= 8'b0;
					if (counter == 8'b100) begin // threshold value for transition to process state
						state <= 2'b10;
					end
				end
				2'b10: begin // process state
					data_out <= data;
					state <= 2'b11;
				end
				2'b11: begin // done state
					valid <= 1'b1;
					state <= 2'b00;
				end
			endcase
		end
	end

endmodule
