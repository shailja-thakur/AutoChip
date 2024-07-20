module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [23:0] register;
	reg [23:0] out_bytes;
	reg done;

	parameter BYTE1 = 2'b00;
	parameter BYTE2 = 2'b01;
	parameter BYTE3 = 2'b10;
	parameter DONE = 2'b11;

	reg [1:0] state;
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= BYTE1;
		else begin
			case (state)
				BYTE1: begin
					if (in[2] == 1)
						state <= BYTE2;
					else
						state <= BYTE1;
				end
				BYTE2: begin
					if (in[2] == 1)
						state <= BYTE3;
					else
						state <= BYTE1;
				end
				BYTE3: begin
					if (in[2] == 1)
						state <= DONE;
					else
						state <= BYTE1;
				end
				DONE: begin
					if (in[2] == 1)
						state <= DONE;
					else
						state <= BYTE1;
				end
			endcase
		end
	end

	always @ (posedge clk) begin
		if (reset)
			register <= 0;
		else if (done)
			register <= 0;
		else
			register <= {register[15:0], in};
	end

	always @ (posedge clk) begin
		if (reset)
			out_bytes <= 0;
		else if (done)
			out_bytes <= register;
	end

	always_comb begin
		done = (state == DONE);
	end

endmodule
