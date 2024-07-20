module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);
	parameter IDLE = 2'b00;
	parameter FIRST_BYTE = 2'b01;
	parameter SECOND_BYTE = 2'b10;
	parameter THIRD_BYTE = 2'b11;

	reg [1:0] state;
	reg [7:0] first;
	reg [7:0] second;
	reg [7:0] third;
	reg [23:0] out;

	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			out <= 0;
		end else begin
			case(state)
				IDLE: begin
					if (in[3] == 1) begin
						state <= FIRST_BYTE;
						first <= in;
					end
				end
				FIRST_BYTE: begin
					state <= SECOND_BYTE;
					second <= in;
				end
				SECOND_BYTE: begin
					state <= THIRD_BYTE;
					third <= in;
				end
				THIRD_BYTE: begin
					state <= IDLE;
					out <= {first, second, third};
				end
			endcase
		end
	end
	
	assign out_bytes = out;
	assign done = (state == THIRD_BYTE);
endmodule
