module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] q_next;
  
  always @(posedge clk) begin
    if (reset) begin
      q <= 32'h1;
    end else begin
      q <= q_next;
    end
  end

  initial begin
    q_next = 32'h1;
    repeat(32) begin
      #1;
      q_next = {q_next[30:0], q_next[21]^q_next[1]^q_next[0]};
    end
  end

endmodule
