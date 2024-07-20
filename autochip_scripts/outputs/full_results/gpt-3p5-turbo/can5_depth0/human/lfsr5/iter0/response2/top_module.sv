module top_module(
  input clk,
  input reset,
  output reg [4:0] q);

  reg [4:0] q_next;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 1;
    end else begin
      q <= q_next;
    end
  end
  
  always @(q[4] or q[2]) begin
    q_next[4:0] = {q[3:0], q[4] ^ q[2]};
  end

endmodule
