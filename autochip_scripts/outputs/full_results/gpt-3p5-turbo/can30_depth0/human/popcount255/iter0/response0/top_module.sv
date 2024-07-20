module top_module (
  input [254:0] in,
  output reg [7:0] out
);
  
  always @* begin
    // Initialize count to 0
    out = 0;
    
    // Loop through each bit of the input vector
    for (int i = 0; i < 255; i = i + 1) begin
      // Check if the current bit is '1'
      if (in[i] == 1'b1) begin
        // Increment the count
        out = out + 1;
      end
    end
  end
endmodule
