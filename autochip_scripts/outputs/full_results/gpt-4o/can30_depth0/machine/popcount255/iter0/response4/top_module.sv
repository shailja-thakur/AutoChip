module top_module (
	input [254:0] in,
	output reg [7:0] out
);

always_comb begin
	out = 8'd0; // Initialize output to 0
	integer i;
	
	for (i = 0; i < 255; i = i + 1) begin
		out = out + in[i]; // Add each bit of input to output
	end
end

endmodule
