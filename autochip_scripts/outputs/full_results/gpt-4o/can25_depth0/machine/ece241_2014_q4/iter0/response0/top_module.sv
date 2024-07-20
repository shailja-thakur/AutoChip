module top_module (
  input clk,
  input x,
  output z
);

  reg [2:0] s;        // 3-bit register s
  initial s = 3'b000; // Initial value of s is 0

  always @(posedge clk) begin
    s[2] = s[2] ^ x;    // Statement 1: MSB of s XORed with x
    s[0] = x;           // LSB of s assigned x
    s[1] = ~(s[1]) & x; // Statement 2: middle bit of s NOTed and ANDed with x
    s[0] = ~(s[0]) | x; // Statement 3: LSB of s NOTed and ORed with x
  end

  assign z = ~(s[2] | s[1] | s[0]); // Output z as NOT of OR of all bits of s

endmodule
