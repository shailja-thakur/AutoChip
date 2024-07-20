module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	// Registers to store intermediate values
	reg [7:0] byte1;
	reg [7:0] byte2;
	reg [7:0] byte3;
	reg [4:0] state;

	// Sequential and combinational logic
	always @(posedge clk) begin
		if (reset) begin
			byte1 <= 8'b0;
			byte2 <= 8'b0;
			byte3 <= 8'b0;
			state <= 5'b0;
			done <= 1'b0;
		end else begin
			case (state)
				0: begin
					if (in[3] == 1'b1) begin
						byte1 <= in;
						state <= 1;
					end
				end
				1: begin
					byte2 <= in;
					state <= 2;
				end
				2: begin
					byte3 <= in;
					state <= 3;
				end
				3: begin
					out_bytes <= {byte1, byte2, byte3};
					state <= 4;
				end
				4: begin
					state <= 0;
					done <= 1'b1;
				end
			endcase
		end
	end

endmodule
