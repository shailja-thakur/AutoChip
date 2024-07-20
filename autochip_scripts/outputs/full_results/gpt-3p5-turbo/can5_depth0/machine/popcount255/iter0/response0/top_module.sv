module top_module (
   input [254:0] in,
   output reg [7:0] out
);

   always_comb begin
      out = 0;  // initialize "out" to 0
      for (int i = 0; i < 255; i = i + 1) begin
         out = out + in[i];  // increment "out" by the value of the corresponding bit in "in"
      end
   end

endmodule
