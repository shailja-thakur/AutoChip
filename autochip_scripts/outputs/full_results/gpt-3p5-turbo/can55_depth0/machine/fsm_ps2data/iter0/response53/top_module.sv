module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	reg [23:0] reg_out_bytes;      // Register to store the shifted bytes
	reg [23:0] next_out_bytes;     // Register to update out_bytes on rising edge of the clock
	reg [1:0] state;               // State register
	reg done_reg;                  // Register to hold the done signal
	wire done = done_reg;          // Output done signal

	always @(posedge clk) begin
		if (reset) begin
			state <= BYTE1;       // Initialize state to BYTE1 on reset
			reg_out_bytes <= 0;   // Reset the register
			next_out_bytes <= 0;  // Reset the register
			done_reg <= 0;       // Reset the done register
		end else begin
			case (state)
				BYTE1: begin
					if (in[2] == 1) begin
						state <= BYTE2;
						next_out_bytes <= reg_out_bytes;
					end else begin
						state <= BYTE1;
						next_out_bytes <= reg_out_bytes;
					end
				end
				BYTE2: begin
					state <= BYTE3;
					next_out_bytes <= reg_out_bytes;
				end
				BYTE3: begin
					state <= DONE;
					next_out_bytes <= reg_out_bytes;
				end
				DONE: begin
					if (in[2] == 0) begin
						state <= BYTE1;
						next_out_bytes <= reg_out_bytes;
					end else begin
						state <= DONE;
						next_out_bytes <= reg_out_bytes;
					end
				end
			endcase
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			reg_out_bytes <= 0;
		end else begin
			reg_out_bytes <= next_out_bytes << 8;   // Shift the register left by 8 bits
		end
	end
	
	always @(posedge clk) begin
		if (state == DONE) begin
			done_reg <= 1;                         // Set done_reg to 1 when in DONE state
		end else begin
			done_reg <= 0;
		end
	end

	assign out_bytes = reg_out_bytes;

endmodule
