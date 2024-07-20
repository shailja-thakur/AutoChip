module top_module(
	input wire clk,
	input wire rst,
	output reg [7:0] data_out,
	output reg valid_out);

	reg [1:0] state;
	reg [7:0] counter;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			state <= 2'b00;
			counter <= 8'b0;
			data_out <= 8'b0;
			valid_out <= 1'b0;
		end else begin
			case(state)
				2'b00: begin // idle state
					counter <= 8'b0;
					data_out <= 8'b0;
					valid_out <= 1'b0;
					if (in == 1'b1) begin
						state <= 2'b01;
					end
				end
				2'b01: begin // wait state
					counter <= counter + 1;
					data_out <= 8'b0;
					valid_out <= 1'b0;
					if (counter == 8'hFF) begin // threshold for transition to process state
						state <= 2'b10;
					end
				end
				2'b10: begin // process state
					data_out <= in;
					state <= 2'b11;
				end
				2'b11: begin // done state
					valid_out <= 1'b1;
					state <= 2'b00;
				end
			endcase
		end
	end

endmodule
