module top_module (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
   if (reset)
      state <= 2'b00;
   else begin
      case (state)
         2'b00:
            if (s)
               state <= 2'b01;
         2'b01:
            state <= (w) ? 2'b10 : 2'b00;
         2'b10:
            state <= (w) ? 2'b11 : 2'b00;
         2'b11:
            if (w)
               state <= 2'b00;
            else
               state <= 2'b10;
      endcase
   end
end

always @(posedge clk) begin
   case (state)
      2'b00:
         z <= 1'b0;
      2'b01:
         z <= 1'b0;
      2'b10:
         z <= 1'b0;
      2'b11:
         z <= 1'b1;
   endcase
end

endmodule
