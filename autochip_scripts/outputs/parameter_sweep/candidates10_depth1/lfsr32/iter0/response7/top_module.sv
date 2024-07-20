module top_module(
    input clk,
    input reset,
    output reg [31:0] q);
  
  always @(posedge clk) begin
    if (reset) begin
      q <= 32'h1;   // reset q to 32'h1 when reset is active high
    end else begin
      if (q[22] ^ q[2] ^ q[1]) begin   // XOR taps at positions 22, 2, and 1
        q <= {q[30:0], q[0]};   // shift q to the left
      end else begin
         q <= q << 1;   // shift q to the left without XORing taps
      end
    end
  end
  
endmodule
