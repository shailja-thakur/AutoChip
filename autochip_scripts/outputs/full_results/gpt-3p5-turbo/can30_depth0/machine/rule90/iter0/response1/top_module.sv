module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  always @(posedge clk) begin
    if (load)    // The operation when load is 1
      q <= data; // Load the input data to the output q.
    else begin   // The operation when load is 0
      q <= q[$bits(q)-1:1] ^ {q[$bits(q)-2:0], 1'b0}; // Shift q to the right and add a 0 at the end.
    end
  end

endmodule
