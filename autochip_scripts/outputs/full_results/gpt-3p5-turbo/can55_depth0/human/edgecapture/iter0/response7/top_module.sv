module top_module(
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out);

  reg [31:0] prev_in;

  always @(posedge clk, posedge reset) begin
    if (reset)
      out <= 32'b0;
    else begin
      for (int i=0; i<32; i=i+1) begin
        if (in[i] && !prev_in[i])
          out[i] <= 1'b1;
        else
          out[i] <= 1'b0;
      end
    end
    prev_in <= in;
  end

endmodule
