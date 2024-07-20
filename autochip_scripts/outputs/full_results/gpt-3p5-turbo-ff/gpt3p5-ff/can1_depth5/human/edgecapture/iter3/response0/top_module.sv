module top_module(
   input clk,
   input reset,
   input [31:0] in,
   output reg [31:0] out);

   reg [31:0] prev_in;
   reg [31:0] edge_detected;

   always @(posedge clk or posedge reset) begin
      if (reset)
         prev_in <= 0;
      else
         prev_in <= in;
   end

   always @(posedge clk) begin
      for (integer i = 0; i < 32; i = i + 1) begin
         if (prev_in[i] && !in[i])
            edge_detected[i] <= 1;
         else
            edge_detected[i] <= 0;
      end
   end

   always @(posedge clk or posedge reset) begin
      if (reset)
         out <= 0;
      else
         out <= out | edge_detected;
   end

endmodule
