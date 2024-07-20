module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 32'h1;
    end
    else begin
      q[31] <= q[22] ^ q[1] ^ q[0];
      q[30:0] <= {q[29:0], q[31]}; // Shift the bits to the left and put the feedback bit at the end
    end
  end

endmodule
