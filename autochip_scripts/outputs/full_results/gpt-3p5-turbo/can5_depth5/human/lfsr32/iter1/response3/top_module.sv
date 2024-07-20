module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] q_next;

  always @(posedge clk) begin
    if (reset) begin
      q_next <= 32'h1;
    end else begin
      q_next <= {q[30:0], q[22]^q[1]^q[0]};
    end
  end

  always @* begin
    q <= q_next;
  end

endmodule
