module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [7:0] reg1;
reg [7:0] reg2;
reg [7:0] reg3;
reg [23:0] out_bytes_reg;
reg done_reg;
reg [1:0] state;

parameter IDLE = 2'b00;
parameter FIRST_BYTE = 2'b01;
parameter SECOND_BYTE = 2'b10;
parameter THIRD_BYTE = 2'b11;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		// reset the registers, output, and state
		reg1 <= 8'b0;
		reg2 <= 8'b0;
		reg3 <= 8'b0;
		out_bytes_reg <= 24'b0;
		done_reg <= 1'b0;
		state <= IDLE;
	end else begin
		case (state)
			IDLE:
				if (in[3]) begin
					reg1 <= in;
					state <= FIRST_BYTE;
				end
			FIRST_BYTE:
				reg2 <= in;
				state <= SECOND_BYTE;
			SECOND_BYTE:
				reg3 <= in;
				state <= THIRD_BYTE;
			THIRD_BYTE:
				done_reg <= 1'b1;
				out_bytes_reg <= {reg3, reg2, reg1};
				state <= IDLE;
		endcase
	end
end

assign out_bytes = out_bytes_reg;
assign done = done_reg;

endmodule
