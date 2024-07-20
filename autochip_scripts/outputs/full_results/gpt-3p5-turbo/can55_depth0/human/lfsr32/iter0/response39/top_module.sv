module top_module(
  input clk,
  input reset,
  output reg [31:0] q
);
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 32'h1; // Reset output q to 32'h1 when reset is active high
    end else begin
      q <= {q[30:0], q[22] ^ q[1] ^ q[0]}; // Calculate next value of q based on taps at bit positions 32, 22, 2, and 1
    end
  end
  
endmodule
