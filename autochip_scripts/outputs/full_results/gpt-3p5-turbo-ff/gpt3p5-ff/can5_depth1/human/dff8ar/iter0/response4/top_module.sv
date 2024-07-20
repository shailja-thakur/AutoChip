module top_module(
  input clk,
  input [7:0] d,
  input areset,
  output reg [7:0] q
);

  // Declaring D flip-flop instances
  reg [7:0] dff_0, dff_1, dff_2, dff_3, dff_4, dff_5, dff_6, dff_7;
  
  // Positive edge clock trigger
  always @(posedge clk) begin
    if (areset) begin
      // Resetting output to 0
      q <= 0;
    end else begin
      // Updating output based on input
      q <= d;
    end
  end

endmodule
