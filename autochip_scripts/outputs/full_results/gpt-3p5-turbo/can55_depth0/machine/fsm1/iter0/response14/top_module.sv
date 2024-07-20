module top_module (
	input clk,
	input wire in,
	input wire areset,
	output wire out
);

	reg [1:0] state;

	always @(posedge areset or posedge clk) begin
		if (areset) begin
			state <= 2'b1;
		end else begin
			if (state == 2'b00) begin
				state <= in ? 2'b00 : 2'b01;
			end else begin
				state <= in ? 2'b01 : 2'b00;
			end
		end
	end

	assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
