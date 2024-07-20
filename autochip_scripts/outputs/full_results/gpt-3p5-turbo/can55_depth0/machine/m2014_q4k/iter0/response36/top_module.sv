module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

	reg [3:0] sr;
	wire msb;
	
	assign msb = sr[3];
	assign out = msb;
	
	always @(posedge clk) begin
		if (!resetn) begin
			sr <= 4'b0;
		end else begin
			sr <= {sr[2:0], in};
		end
	end

endmodule
