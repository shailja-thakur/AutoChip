module top_module (
   input clk,
   input [7:0] in,
   input reset,
   output done
);

   reg [2:0] state;
   wire third_bit;
   assign third_bit = in[2];
   
   always @(posedge clk or posedge reset) begin
      if (reset)
         state <= 3'b000;
      else if (third_bit && state == 3'b000)
         state <= 3'b001;
      else if (state == 3'b001)
         state <= 3'b010;
      else if (state == 3'b010)
         state <= 3'b011;
      else if (state == 3'b011) begin
         if (third_bit)
            state <= 3'b001;
         else
            state <= 3'b100;
      end
      else if (state == 3'b100)
         state = 3'b000;
      else
         state = 3'b000;
   end
   
   assign done = (state == 3'b011);

endmodule
