module top_module (
  input clk,
  input reset,
  output reg [31:0] q
);

  reg [31:0] q_next;

  always @(posedge clk) begin
    if (reset) begin
      q <= 32'h1;
    end else begin
      q <= q_next;
    end
  end
  
  always @(*) begin
    q_next[31] = q[0] ^ q[21] ^ q[1];
    q_next[30:0] = q[31:1];
  end

endmodule
