module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b01;
		end else begin
			if (state == 2'b00 && in) begin
				state <= 2'b00; // A state
			end else if (state == 2'b00 && !in) begin
				state <= 2'b01; // B state
			end else if (state == 2'b01 && in) begin
				state <= 2'b01; // B state
			end else if (state == 2'b01 && !in) begin
				state <= 2'b00; // A state
			end
		end
	end

	assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
