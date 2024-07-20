module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	reg [1:0] state;
	reg [7:0] shifted_in;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			shifted_in <= 8'b0;
			out_bytes <= 24'b0;
			done <= 1'b0;
		end
		else begin
			case (state)
				0: begin // BYTE1 state
					if (in[2] == 1'b1) // transition condition from BYTE1 to BYTE2
						state <= 1;
					else
						state <= 0;
				end
				1: begin // BYTE2 state
					if (in[2] == 1'b1) // transition condition from BYTE2 to BYTE3
						state <= 2;
					else
						state <= 0;
				end
				2: begin // BYTE3 state
					state <= 3; // transition from BYTE3 to DONE
				end
				3: begin // DONE state
					if (in[2] == 1'b0) // transition condition from DONE to BYTE1
						state <= 0;
					else
						state <= 3;
				end
				default: state <= 0;
			endcase
		end
	end

	always @(posedge clk) begin
		if (state == 0) // BYTE1 state
			shifted_in <= in;
		else if (state == 3) // DONE state
			shifted_in <= shifted_in << 8; // shift left by 8 bits
	end

	always @(posedge clk) begin
		if (state == 3) // done condition
			out_bytes <= shifted_in;
	end

	always @(posedge clk) begin
		if (state == 3)
			done <= 1'b1;
		else
			done <= 1'b0;
	end

endmodule
