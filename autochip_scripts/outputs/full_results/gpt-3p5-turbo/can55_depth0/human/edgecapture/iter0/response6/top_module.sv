module top_module(
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out);

  reg [31:0] prev_in; // store previous value of input

  always @(posedge clk or posedge reset) begin
    if (reset)
      prev_in <= 0; // reset previous value
    else
      prev_in <= in; // store current value
  end

  always @(posedge clk or posedge reset) begin
    if (reset)
      out <= 0; // reset output
    else begin
      for (integer i = 0; i < 32; i = i + 1) begin
        if (prev_in[i] && !in[i])
          out[i] <= 1; // input changed from 1 to 0, set output to 1
        else
          out[i] <= 0; // no change or input changed from 0 to 1, set output to 0
      end
    end
  end
endmodule
