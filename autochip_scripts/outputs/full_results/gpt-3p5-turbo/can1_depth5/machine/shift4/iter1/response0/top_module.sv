module top_module(
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q);

  always @(posedge clk) begin
    if (areset == 0) begin
      q <= 4'b0000;
    end else if (load == 1) begin
      q <= data;
    end else if (ena == 1) begin
      q <= {q[1:0], q[3:2]};
    end
  end

endmodule
