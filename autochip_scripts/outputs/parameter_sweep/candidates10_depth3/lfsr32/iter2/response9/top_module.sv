module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] next_state;

  always @(posedge clk) begin
    if (reset)
      q <= 32'h1;
    else begin
      q <= next_state;
    end
  end

  always @* begin
    next_state[0] = q[31] ^ q[21] ^ q[1] ^ q[0];
    next_state[31:1] = q[30:0];
  end

endmodule
