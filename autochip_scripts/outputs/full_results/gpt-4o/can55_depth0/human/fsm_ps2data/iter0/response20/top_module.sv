module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// State declaration
	typedef enum logic [1:0] {
		IDLE,
		BYTE1,
		BYTE2,
		BYTE3
	} state_t;
	
	state_t state, next_state;
	reg [23:0] temp_bytes;

	// Synchronous reset and state transition
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			out_bytes <= 24'b0;
			done <= 1'b0;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
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

	// Output logic and state actions
	always @(posedge clk) begin
		if (reset) begin
			out_bytes <= 24'b0;
			temp_bytes <= 24'b0;
			done <= 1'b0;
		end else begin
			done <= 1'b0;
			case (state)
				IDLE: begin
					if (in[3]) begin
						temp_bytes[23:16] <= in;
					end
				end
				BYTE1: begin
					temp_bytes[15:8] <= in;
				end
				BYTE2: begin
					temp_bytes[7:0] <= in;
				end
				BYTE3: begin
					out_bytes <= {temp_bytes[23:8], in};
					done <= 1'b1;
				end
			endcase
		end
	end

endmodule
