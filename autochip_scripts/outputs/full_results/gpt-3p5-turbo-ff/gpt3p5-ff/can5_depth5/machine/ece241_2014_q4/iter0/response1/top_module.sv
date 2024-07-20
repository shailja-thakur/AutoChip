module top_module (
  input clk,
  input x,
  output z
);

  reg [2:0] s = 3'b000; // Declare register s with 3 bits and initial value 0

  always @(posedge clk) begin
    // Statement 1
    s[2] <= s[2] ^ x; // XOR value of x with MSB of s
    s[0] <= x; // Assign value of x to LSB of s
    
    // Statement 2
    s[1] <= ~s[1] & x; // Apply NOT operator to middle bit of s and AND with value of x
    
    // Statement 3
    s[0] <= ~s[0] | x; // Apply NOT operator to LSB of s and OR with value of x
  end

  assign z = ~(|s); // Apply OR operator to all bits of s and then apply NOT operator to the result

endmodule
