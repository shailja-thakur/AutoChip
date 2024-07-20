module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [7:0] state;
	reg [23:0] out_reg;
	wire done_wire;

	parameter BYTE1 = 2'b00;
	parameter BYTE2 = 2'b01;
	parameter BYTE3 = 2'b10;
	parameter DONE = 2'b11;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
			done_wire <= 0;
			out_reg <= 0;
		end else begin
			case(state)
				BYTE1: begin
					if (in[2] == 1'b1) begin
						state <= BYTE2;
					end else begin
						state <= BYTE1;
					end
				end
				BYTE2: begin
					state <= BYTE3;
				end
				BYTE3: begin
					state <= DONE;
				end
				DONE: begin
					if (in[2] == 1'b0) begin
						state <= BYTE1;
					end else begin
						state <= DONE;
					end
				end
			endcase
			if (state == DONE) begin
				done_wire <= 1'b1;
			end else begin
				done_wire <= 1'b0;
			end
		end
	end

	always @(posedge clk) begin
		if (state == DONE) begin
			out_reg <= out_reg << 8;
			out_reg[7:0] <= in;
		end
	end

	assign out_bytes = out_reg;

	assign done = done_wire;

endmodule
