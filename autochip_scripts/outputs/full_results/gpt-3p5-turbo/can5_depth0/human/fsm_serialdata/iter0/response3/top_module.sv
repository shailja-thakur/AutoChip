module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	reg [3:0] state;
	reg [7:0] data;
	reg [2:0] bit_count;
	reg start_bit_found;
	reg stop_bit_found;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0000;
			data <= 8'b0;
			bit_count <= 3'b000;
			start_bit_found <= 1'b0;
			stop_bit_found <= 1'b0;
		end else begin
			case (state)
				4'b0000: begin // Idle state
					if (in == 1'b1)
						state <= 4'b0001;
				end
				4'b0001: begin // Start bit state
					if (in == 1'b0) begin
						start_bit_found <= 1'b1;
						state <= 4'b0010;
						bit_count <= 3'b000;
					end else
						state <= 4'b0000;
				end
				4'b0010: begin // Data bit states
					if (bit_count == 3'b111) begin
						if (in == 1'b1) begin
							stop_bit_found <= 1'b1;
							state <= 4'b0011;
						end else
							state <= 4'b0000;
					end else begin
						data[bit_count] <= in;
						bit_count <= bit_count + 1'b1;
					end
				end
				4'b0011: begin // Done state
					if (in == 1'b0) begin
						state <= 4'b0000;
						done <= 1'b1;
						out_byte <= data;
					end else begin
						done <= 1'b0;
						state <= 4'b0000;
					end
				end
			endcase
		end
	end

endmodule
