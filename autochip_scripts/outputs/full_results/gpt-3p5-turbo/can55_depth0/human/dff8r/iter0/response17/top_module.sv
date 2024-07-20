module top_module(
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);

  // Reset signal for synchronous reset
  reg [7:0] reset_out;

  // D flip-flops
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      reset_out <= 8'b0; // Reset the output to zero
    end else begin
      reset_out <= d; // Update the output with the input
    end
  end

  // Assign the output
  always @(posedge clk) begin
    q <= reset_out;
  end

endmodule
