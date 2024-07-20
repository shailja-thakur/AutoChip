module top_module(
  input clk,
  input reset,
  output reg [4:0] q);

  reg [4:0] q_next;

  // always block for state transition of q
  always @* begin
    q_next[4:1] = q[3:0];
    q_next[0] = q[4];
    q_next[2] = q[2] ^ q[0];
  end

  // always block for updating q at positive edge of clk
  always @(posedge clk) begin
    if (reset) begin
      q <= 5'b1;
    end else begin
      q <= q_next;
    end
  end

endmodule
