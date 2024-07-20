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

always @(posedge clk or posedge reset) begin
	if (reset) begin
		// reset the registers and output
		reg1 <= 8'b0;
		reg2 <= 8'b0;
		reg3 <= 8'b0;
		out_bytes_reg <= 24'b0;
		done_reg <= 1'b0;
	end else begin
		// shift the registers
		reg1 <= reg2;
		reg2 <= reg3;
		reg3 <= in;
		
		// check for message boundaries
		if (done_reg) begin
			done_reg <= 1'b0;
		end else if (!reg1[3] && reg2[3] && !reg3[3]) begin
			done_reg <= 1'b1;
			out_bytes_reg <= {reg1, reg2, reg3};
		end else begin
			done_reg <= 1'b0;
		end
	end
end

assign out_bytes = out_bytes_reg;
assign done = done_reg;

endmodule
