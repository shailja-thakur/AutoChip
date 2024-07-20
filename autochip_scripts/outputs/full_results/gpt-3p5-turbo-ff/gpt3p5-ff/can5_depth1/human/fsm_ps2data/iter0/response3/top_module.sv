module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [2:0] state;
	reg [7:0] byte1;
	reg [7:0] byte2;
	reg [7:0] byte3;

	always @(posedge clk) begin
		if (reset)
			state <= 0;
		else begin
			case (state)
				0: begin // Waiting for byte with in[3]=1
					if (in[3])
						state <= 1;
				end
				1: begin // Receiving byte 1
					byte1 <= in;
					state <= 2;
				end
				2: begin // Receiving byte 2
					byte2 <= in;
					state <= 3;
				end
				3: begin // Receiving byte 3
					byte3 <= in;
					state <= 0;
				end
			endcase
		end
	end

	always @(*) begin
		if (state == 3)
			done = 1;
		else
			done = 0;
	end

	assign out_bytes = {byte1, byte2, byte3};

endmodule
