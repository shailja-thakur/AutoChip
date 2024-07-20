module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	reg [1:0] state, next_state;

	localparam IDLE = 2'b00,
			   BYTE1 = 2'b01,
			   BYTE2 = 2'b10,
			   BYTE3 = 2'b11;

	// State transition logic
	always @ (posedge clk) begin
		if (reset) begin
			state <= IDLE;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @ (*) begin
		case (state)
			IDLE: begin
				if (in[3]) begin
					next_state = BYTE1;
				end else begin
					next_state = IDLE;
				end
			end
			BYTE1: begin
				next_state = BYTE2;
			end
			BYTE2: begin
				next_state = BYTE3;
			end
			BYTE3: begin
				next_state = IDLE;
			end
			default: begin
				next_state = IDLE;
			end
		endcase
	end

	// Output and data capture logic
	always @ (posedge clk) begin
		if (reset) begin
			out_bytes <= 24'b0;
			done <= 0;
		end else begin
			done <= 0;
			case (state)
				IDLE: begin
					// Do nothing
				end
				BYTE1: begin
					out_bytes[23:16] <= in;
				end
				BYTE2: begin
					out_bytes[15:8] <= in;
				end
				BYTE3: begin
					out_bytes[7:0] <= in;
					done <= 1;
				end
			endcase
		end
	end

endmodule
