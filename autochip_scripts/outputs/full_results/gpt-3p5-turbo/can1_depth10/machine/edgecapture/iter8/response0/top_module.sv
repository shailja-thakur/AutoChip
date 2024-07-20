module top_module(
  input wire clk,
  input wire reset,
  input wire [31:0] in,
  output reg [31:0] out);

  reg [31:0] d_last;
  reg [31:0] out_reg;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out_reg <= 0;
      d_last <= 0;
      out <= 0; // Reset the output to 0 during reset
    end else begin
      d_last <= in;
      out_reg <= out_reg | (~in & d_last);
      out <= out_reg; // Assign the output value
    end
  end

endmodule
