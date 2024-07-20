module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] q_next;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 32'h1;
    end else begin
      q <= q_next;
    end
  end

  always @* begin
    q_next[31] = q[21] ^ q[20] ^ q[19] ^ q[18] ^ q[16] ^ q[14] ^ q[13] ^ q[11] ^ q[10] ^ q[8] ^ q[7] ^ q[6] ^ q[5] ^ q[4] ^ q[3] ^ q[2] ^ q[1] ^ q[0];
    q_next[30:0] = q[31:1];
  end

endmodule
