module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);
	reg [3:0] state;
	reg [7:0] data_byte;
	reg start_bit;
	reg [2:0] bit_count;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			data_byte <= 0;
			start_bit <= 0;
			bit_count <= 0;
		end else begin
			case (state)
				0: begin // Idle state
					if (in == 1'b0)
						state <= 1;
				end
				1: begin // Start bit detected
					start_bit <= 1;
					bit_count <= 0;
					state <= 2;
				end
				2: begin // Receive data bits
					if (bit_count < 8) begin
						data_byte[bit_count] <= in;
						bit_count <= bit_count + 1;
					end else begin
						state <= 3;
					end
				end
				3: begin // Verify stop bit
					if (in == 1'b1) begin
						state <= 0;
						if (start_bit == 1 && bit_count == 8)
							done <= 1;
						else
							done <= 0;
					end
				end
			endcase
		end
	end

	assign out_byte = data_byte;

endmodule
