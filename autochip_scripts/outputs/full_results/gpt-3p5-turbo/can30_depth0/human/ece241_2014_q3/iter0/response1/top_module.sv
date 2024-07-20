module top_module (
   input c,
   input d,
   output reg [3:0] mux_in
);

   reg [1:0] ab;
   
   always @*
   begin
      case({c, d})
         2'b00: ab = 2'b00;
         2'b01: ab = 2'b01;
         2'b11: ab = 2'b10;
         2'b10: ab = 2'b11;
      endcase
   end
   
   always @(ab)
   begin
      case(ab)
         2'b00: mux_in = 4'b0001;
         2'b01: mux_in = 4'b1000;
         2'b10: mux_in = 4'b1011;
         2'b11: mux_in = 4'b1101;
      endcase
   end

endmodule
