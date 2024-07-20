module top_module(
   input clk,
   input reset,
   input [31:0] in,
   output reg [31:0] out
);

   reg [31:0] in_d;   // Delayed input signal
   
   always @(posedge clk or posedge reset) begin
      if (reset) begin
         in_d <= 0;
         out <= 0;
      end
      else begin
         in_d <= in;
         
         // Check for rising edge on each bit of the input vector
         for (integer i = 0; i < 32; i = i + 1) begin
            if (in_d[i] && !in[i]) begin
               out[i] <= 1;
            end
            else begin
               out[i] <= 0;
            end
         end
      end
   end

endmodule
