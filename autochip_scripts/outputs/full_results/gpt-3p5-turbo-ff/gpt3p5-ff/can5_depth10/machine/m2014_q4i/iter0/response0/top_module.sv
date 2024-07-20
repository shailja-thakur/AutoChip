module top_module(
  output reg out);      // Added reg keyword for output port
  always @(posedge clk) begin
    out <= 1'b0;        // Assigned binary value 0 to the output port
  end
endmodule
