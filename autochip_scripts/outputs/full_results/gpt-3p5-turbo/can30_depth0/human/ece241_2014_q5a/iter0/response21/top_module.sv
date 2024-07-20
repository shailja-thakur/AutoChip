module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

reg [7:0] count;

always @(posedge clk or negedge areset) begin
	if (areset == 0) begin
		z <= 0;
		count <= 0;
	end else begin
		if (x == 1) begin
			count <= count + 1;
		end else begin
			count <= count;
		end
		
		if (count == 8) begin
			z <= ~x + 1;
			count <= 0;
		end else begin
			z <= z;
		end
	end
end

endmodule
