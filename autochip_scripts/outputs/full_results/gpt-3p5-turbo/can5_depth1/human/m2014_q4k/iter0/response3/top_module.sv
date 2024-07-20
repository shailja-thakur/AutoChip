module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

	reg [3:0] dff;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			dff <= 4'b0;
		end else begin
			dff <= {dff[2:0], in};
		end
	end

	assign out = dff[3];

endmodule
