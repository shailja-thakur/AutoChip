module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] d_reg;
reg [3:0] q_reg;

// Synchronous reset
always @(posedge clk or negedge resetn) begin
	if (resetn == 0) begin
		d_reg <= 4'b0;
		q_reg <= 4'b0;
	end else begin
		d_reg <= {d_reg[2:0], in};
		q_reg <= d_reg;
	end
end

assign out = q_reg[3];

endmodule
