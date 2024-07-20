module top_module(
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q);

  // Define internal signal for the load operation
  reg [3:0] q_next;

  always @(posedge clk or posedge areset) begin
    // Reset the shift register when areset is asserted
    if (areset)
      q <= 4'b0000;
    // Load data into the shift register when load is asserted
    else if (load)
      q <= data;
    // Shift right when ena is asserted
    else if (ena)
      q <= {q[2:0], 1'b0};
  end

endmodule
