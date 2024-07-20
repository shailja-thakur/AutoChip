module top_module (
  input [7:0] a,
  input [7:0] b,
  input [7:0] c,
  input [7:0] d,
  output reg [7:0] min
);

  always @(a or b or c or d) begin
    min = a; // Assume a is the minimum initially
    
    if (b < min) // Compare b with the current minimum
      min = b;
    if (c < min) // Compare c with the current minimum
      min = c;
    if (d < min) // Compare d with the current minimum
      min = d;
  end

endmodule
