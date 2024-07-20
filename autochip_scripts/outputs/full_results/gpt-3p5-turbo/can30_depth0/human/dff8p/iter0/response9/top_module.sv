module top_module(
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);

  reg [7:0] q_temp; // temporary register to store the new value of q

  always @(negedge clk) begin
    if (reset)
      q_temp <= 8'd34; // reset q_temp to 0x34 when reset is active
    else
      q_temp <= d; // update q_temp with input d
  end

  // assign q the value of q_temp to update q synchronously
  always @(posedge clk) begin
    q <= q_temp;
  end

endmodule
