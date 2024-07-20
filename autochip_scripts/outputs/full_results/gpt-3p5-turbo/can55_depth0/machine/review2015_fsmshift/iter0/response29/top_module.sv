module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
		end else if (state == 3'b011) begin
			state <= 3'b100;
		end else if (state == 3'b100) begin
			state <= 3'b101;
		end else if (state == 3'b101) begin
			state <= 3'b110;
		end else if (state == 3'b110) begin
			state <= 3'b111;
		end else begin
			state <= 3'b001;
		end
	end

	assign shift_ena = (state == 3'b000) || (state == 3'b011) || (state == 3'b100) || (state == 3'b101) || (state == 3'b110) || (state == 3'b111);
	
endmodule
