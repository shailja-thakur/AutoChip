module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

  reg [4:0] q_next;

  // First always block: defines the state transition of q
  always @(*) begin
    q_next = q[4:1];      // q_next is assigned with q except the LSB bit
    q_next[4] = q[0];     // q_next[4] is assigned with q[0], the LSB bit
    q_next[2] = q_next[2] ^ q[0];  // q_next[2] is XOR'd with q[0]
  end

  // Second always block: logic description and state assignment on the positive edge of clk
  always @(posedge clk) begin
    if (reset)
      q <= 5'h1;          // q is assigned with reset value 5'h1 when reset is active
    else
      q <= q_next;        // q is assigned with q_next which is state transition value
  end

endmodule
