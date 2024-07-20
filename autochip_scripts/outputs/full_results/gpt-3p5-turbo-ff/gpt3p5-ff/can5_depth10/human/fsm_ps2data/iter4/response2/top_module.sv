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
parameter PROCESS = 2'b01;
parameter OUTPUT = 2'b10;

always @(posedge clk) begin
	if (reset) begin
		// reset the registers and output
		reg1 <= 8'b0;
		reg2 <= 8'b0;
		reg3 <= 8'b0;
		out_bytes_reg <= 24'b0;
		done_reg <= 1'b0;
		state <= IDLE;
	end else begin
		case (state)
			IDLE:
				if (in[3] == 1'b1) begin
					reg1 <= in;
					state <= PROCESS;
				end
			PROCESS:
				reg1 <= reg2;
				reg2 <= reg3;
				reg3 <= in;
				if (reg1[3] && !reg2[3] && !reg3[3]) begin
					out_bytes_reg[23:16] <= reg1;
					out_bytes_reg[15:8] <= reg2;
					out_bytes_reg[7:0] <= reg3;
					state <= OUTPUT;
				end
			OUTPUT:
				done_reg <= 1'b1;
				state <= IDLE;
			default:
				state <= IDLE;
		endcase
	end
end

assign out_bytes = out_bytes_reg;
assign done = done_reg;

endmodule
