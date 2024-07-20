module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// State enumeration
	localparam IDLE = 2'b00;
	localparam BYTE1 = 2'b01;
	localparam BYTE2 = 2'b10;
	localparam BYTE3 = 2'b11;
	
	reg [1:0] state, next_state;
	reg [23:0] message;

	// State transitions
	always @(posedge clk) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			IDLE: next_state = (in[3] == 1'b1) ? BYTE1 : IDLE;
			BYTE1: next_state = BYTE2;
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = IDLE;
			default: next_state = IDLE;
		endcase
	end

	// Output logic and message latching
	always @(posedge clk) begin
		if (reset) begin
			out_bytes <= 24'b0;
			message <= 24'b0;
			done <= 1'b0;
		end
		else begin
			done <= 1'b0;  // Default done signal
			case (state)
				IDLE: begin
					if (in[3] == 1'b1) begin
						message[23:16] <= in;
					end
				end
				BYTE1: begin
					message[15:8] <= in;
				end
				BYTE2: begin
					message[7:0] <= in;
				end
				BYTE3: begin
					out_bytes <= {message[23:8], in}; // Complete message with latest byte
					done <= 1'b1;
				end
			endcase
		end
	end

endmodule
