module top_module(
  input clk,
  input reset,
  output reg [4:0] q);

  // always block for state transition of q
  always @(q) begin
    reg [4:1] q_next;
    q_next = q[4:1];
    q_next[4] = q[0];
    q_next[2] = q[2] ^ q[0];
    q = q_next;
  end

  // always block for positive edge of clk
  always @(posedge clk) begin
    if (reset) begin
      q <= 5'b00001;
    end else begin
      q <= q_next;
    end
  end

endmodule
