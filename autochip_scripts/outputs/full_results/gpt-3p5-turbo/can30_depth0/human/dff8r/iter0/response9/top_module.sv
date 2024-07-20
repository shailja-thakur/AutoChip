module top_module(
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);

reg [7:0] q_tmp;  // Temporary register for storing intermediate values

always @(posedge clk or posedge reset) begin
  if (reset) begin
    q_tmp <= 8'b0;  // Reset to zero when reset signal is active
  end else begin
    q_tmp <= d;     // Store input data when clock signal is positive edge
  end
end

// Output register
always @(posedge clk) begin
  q <= q_tmp;
end

endmodule
