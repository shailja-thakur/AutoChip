module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	
	reg [1:0] state;
	reg [7:0] byte1;
	reg [7:0] byte2;
	reg [7:0] byte3;
	reg [23:0] message;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			byte1 <= 0;
			byte2 <= 0;
			byte3 <= 0;
			message <= 0;
		end else begin
			case (state)
				0: begin // Idle state
					if (in[3] == 1) begin
						state <= 1; // Transition to State 1
						byte1 <= in;
					end
				end
				1: begin // State 1: Receive byte 2
					byte2 <= in;
					state <= 2; // Transition to State 2
				end
				2: begin // State 2: Receive byte 3
					byte3 <= in;
					state <= 3; // Transition to State 3
				end
				3: begin // State 3: Output the message
					message <= {byte1, byte2, byte3};
					state <= 0; // Transition to Idle state
				end
				default: state <= 0;
			endcase
		end
	end
	
	assign out_bytes = message;
	assign done = (state == 3);

endmodule
