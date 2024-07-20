module top_module(
   input clk,
   input reset,
   input [31:0] in,
   output reg [31:0] out);

   reg [31:0] prev_in;

   always @(posedge clk or posedge reset) begin
      if (reset)
         prev_in <= 0;
      else
         prev_in <= in;
   end

   always @(posedge clk) begin
      for (integer i = 0; i < 32; i = i + 1) begin
         if (prev_in[i] && !in[i])
            out[i] <= 1;
         else if (reset)
            out[i] <= 0;
      end
   end

endmodule
