module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	reg [1:0] state, next_state;
	reg [23:0] temp_bytes;
	
	localparam IDLE = 2'b00,
			   BYTE1 = 2'b01,
			   BYTE2 = 2'b10,
			   DONE = 2'b11;

	// State transition
	always @(posedge clk) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case(state)
			IDLE: begin
				if (in[3])
					next_state = BYTE1;
				else
					next_state = IDLE;
			end
			BYTE1: begin
				next_state = BYTE2;
			end
			BYTE2: begin
				next_state = DONE;
			end
			DONE: begin
				next_state = IDLE;
			end
			default: next_state = IDLE;
		endcase
	end

	// Output logic and message storage
	always @(posedge clk) begin
		if (reset) begin
			temp_bytes <= 24'd0;
			out_bytes <= 24'dx;
			done <= 1'b0;
		end else begin
			case(state)
				IDLE: begin
					done <= 1'b0;
				end
				BYTE1: begin
					temp_bytes[23:16] <= in;
				end
				BYTE2: begin
					temp_bytes[15:8] <= in;
				end
				DONE: begin
					temp_bytes[7:0] <= in;
					out_bytes <= temp_bytes;
					done <= 1'b1;
				end
				default: begin
					out_bytes <= 24'dx;
					done <= 1'b0;
				end
			endcase
		end
	end
endmodule
