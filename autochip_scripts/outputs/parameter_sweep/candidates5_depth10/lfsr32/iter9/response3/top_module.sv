module top_module(
  input clk,
  input reset,
  output reg [31:0] q
);

  reg [31:0] q_next;

  always @(posedge clk or posedge reset) begin
    if (reset)
      q_next <= 32'h1;
    else begin
      q_next <= {q[30:0], q[22] ^ q[21] ^ q[1] ^ q[0]};
    end
  end
  
  always @(posedge clk) begin
    if (reset)
      q <= q_next;
    else
      q <= q_next;
  end

endmodule
