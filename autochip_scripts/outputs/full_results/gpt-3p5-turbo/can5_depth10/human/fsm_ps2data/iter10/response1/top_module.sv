module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	reg [1:0] state;
	reg [2:0] counter;
	reg [7:0] byte0;
	reg [7:0] byte1;
	reg [23:0] message;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00;
			counter <= 3'b000;
			byte0 <= 8'b0;
			byte1 <= 8'b0;
			message <= 24'b0;
			out_bytes <= 24'b0;
			done <= 0;
		end
		else begin
			case (state)
				2'b00: begin
					if (in[3]) begin
						state <= 2'b01;
						byte0 <= in;
						counter <= 3'b001;
					end
				end
				2'b01: begin
					if (counter == 3'b010) begin
						state <= 2'b10;
					end
					else if (byte1[3]) begin
						state <= 2'b01;
						byte0 <= byte1;
						byte1 <= in;
						counter <= counter + 1;
					end
					else begin
						byte1 <= in;
					end
				end
				2'b10: begin
					state <= 2'b00;
					message <= {byte0, byte1, in};
					out_bytes <= message;
					done <= 1;
				end
			endcase
		end
	end
endmodule
