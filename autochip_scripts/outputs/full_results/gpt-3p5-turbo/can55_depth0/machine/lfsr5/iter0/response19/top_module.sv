module top_module(
  input clk,
  input reset,
  output reg [4:0] q);

  reg [4:0] q_next;

  always @(q) begin
    q_next[4:1] = q[4:1]; // q_next is assigned with q[4:1], which is the value of q except the LSB bit.
    q_next[4] = q[0]; // q_next[4] is assigned with q[0], which is the LSB bit.
    q_next[2] = q_next[2] ^ q[0]; // q_next[2] is xored with q[0].
  end

  always @(posedge clk) begin
    if (reset) begin
      q = 5'h1; // reset value
    end
    else begin
      q = q_next; // state transition
    end
  end
  
endmodule
