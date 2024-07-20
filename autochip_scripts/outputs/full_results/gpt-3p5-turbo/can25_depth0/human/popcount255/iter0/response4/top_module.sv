module top_module (
	input [254:0] in,
	output reg [7:0] out
);

always @(*) begin
  // Initialize output to zero
  out = 0;
  
  // Iterate over each bit of the input vector
  for (int i = 0; i < 255; i = i + 1) begin
    // Check if the current bit is '1'
    if (in[i] == 1'b1) begin
      // Increment the output by 1
      out = out + 1;
    end
  end
end

endmodule
