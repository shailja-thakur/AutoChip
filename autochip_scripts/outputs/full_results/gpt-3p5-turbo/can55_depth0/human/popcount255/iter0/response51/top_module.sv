module top_module (
	input [254:0] in,
	output reg [7:0] out
);

always @(*) begin
	reg [7:0] count;
	integer i;
	
	count = 0;
	for (i = 0; i < 255; i = i + 1) begin
		if (in[i] == 1'b1) begin
			count = count + 1;
		end
	end
	
	out = count;
end

endmodule
