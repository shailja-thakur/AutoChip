module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);
	
	reg [2:0] state;
	reg [7:0] byte_value;
	reg start_bit_found;
	reg stop_bit_found;
	reg [2:0] bit_counter;
	
	parameter IDLE = 3'b000;
	parameter START_BIT = 3'b001;
	parameter DATA_BIT = 3'b010;
	parameter STOP_BIT = 3'b100;

	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			byte_value <= 8'b0;
			start_bit_found <= 1'b0;
			stop_bit_found <= 1'b0;
			bit_counter <= 3'b000;
		end else begin
			case (state)
				IDLE: begin
					if (in == 1'b0) begin
						start_bit_found <= 1'b1;
						state <= START_BIT;
						bit_counter <= 3'b001;
					end
				end
				
				START_BIT: begin
					if (bit_counter == 3'b000) begin
						if (in == 1'b0) begin
							state <= DATA_BIT;
						end else begin
							state <= IDLE;
						end
					end else begin
						if (in == 1'b0) begin
							bit_counter <= bit_counter + 1'b1;
						else begin
							state <= IDLE;
						end
					end
				end
				
				DATA_BIT: begin
					if (bit_counter == 3'b111) begin
						state <= STOP_BIT;
					end else begin
						bit_counter <= bit_counter + 1'b1;
						byte_value[bit_counter] <= in;
					end
				end
				
				STOP_BIT: begin
					if (in == 1'b1) begin
						stop_bit_found <= 1'b1;
						state <= IDLE;
						if (stop_bit_found && start_bit_found) begin
							done <= 1'b1;
							out_byte <= byte_value;
						end else begin
							done <= 1'b0;
						end
					end
				end
			endcase
		end
	end
endmodule
