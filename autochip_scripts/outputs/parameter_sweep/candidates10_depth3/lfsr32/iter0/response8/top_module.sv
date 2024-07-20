module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  always @(posedge clk) begin
    if (reset)
      q <= 32'b1;
    else begin
      q <= {q[31]^q[30]^q[20]^q[0], q[31:1]};
    end
  end

endmodule
