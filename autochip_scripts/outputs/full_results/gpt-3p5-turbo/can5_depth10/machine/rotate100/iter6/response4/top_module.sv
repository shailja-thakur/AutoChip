module top_module(
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);

  reg [99:0] q_next;

  always @(posedge clk) begin
    if (load) begin
      q_next <= data;
    end else if (ena == 2'b01) begin
      q_next <= {q[98:0], q[99]};
    end else if (ena == 2'b10) begin
      q_next <= {q[0], q[99:1]};
    end
  end

  always @(posedge clk) begin
    q <= q_next;
  end

endmodule
