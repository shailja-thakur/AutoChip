module top_module(
	input wire clk,
	input wire rst,
	output wire data_out,
	output wire valid_out);

	reg [1:0] state;
	reg [15:0] counter;
	wire [15:0] threshold = 16'd100;

	assign out = data_out;
	
	always @(posedge clk or posedge rst) begin
		if (rst == 1'b1) begin
			state <= 2'b00; // idle state
			counter <= 16'd0;
			data_out <= 16'd0;
			valid_out <= 1'b0;
		end else begin
			case (state)
				2'b00: begin // idle state
					counter <= 16'd0;
					data_out <= 16'd0;
					valid_out <= 1'b0;
					if (rst == 1'b0) begin
						state <= 2'b01; // wait state
					end
				end
				
				2'b01: begin // wait state
					if (counter < threshold) begin
						counter <= counter + 1;
						data_out <= 16'd0;
						valid_out <= 1'b0;
					end else begin
						counter <= 16'd0;
						state <= 2'b10; // process state
					end
				end
				
				2'b10: begin // process state
					data_out <= in;
					state <= 2'b11; // done state
				end
				
				2'b11: begin // done state
					valid_out <= 1'b1;
					state <= 2'b00; // idle state
				end
			endcase
		end
	end

endmodule
