module top_module(
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out);

  reg [31:0] d_last; // previous value of in

  always @(posedge clk) begin
    if (reset) begin
      d_last <= 0; // reset to 0
      out <= 0; // reset to 0
    end
    else begin
      d_last <= in; // store previous value of in
      out <= out | (~in & d_last); // modify out value
    end
  end

endmodule
