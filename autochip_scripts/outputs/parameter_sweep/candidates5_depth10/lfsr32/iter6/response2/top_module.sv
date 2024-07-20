module lfsr32(
  input clk,
  input reset,
  output reg [31:0] q
);

  always @(posedge clk) begin
    if (reset)
      q <= 32'h1;
    else begin
      q <= {q[30:0], q[21] ^ q[1] ^ q[0]};
    end
  end

endmodule
module top_module(
  input clk,
  input reset,
  output reg [31:0] q
);

  lfsr32 lfsr(
    .clk(clk),
    .reset(reset),
    .q(q)
  );

endmodule
