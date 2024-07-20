module top_module (
   input clk,
   input resetn,
   input x,
   input y,
   output f,
   output g
);
   reg [1:0] state;

   always @(posedge clk or negedge resetn)
   begin
      if (!resetn)
         state <= 2'b00;
      else
      begin
         case (state)
            2'b00: begin
               f <= 1'b0;
               g <= 1'b0;
               if (!resetn)
                   state <= 2'b11;
               else if (resetn && (posedge clk))
                   state <= 2'b01;
            end
            2'b01: begin
               f <= 1'b1;
               g <= 1'b0;
               state <= 2'b10;
            end
            2'b10: begin
               if ((x == 1'b1) && (posedge clk))
                   state <= 2'b11;
               else if (!((x == 1'b1) && (posedge clk)))
                   state <= 2'b11;
            end
            2'b11: begin
               if ((x == 1'b1) && (posedge clk))
               begin
                   f <= 1'b0;
                   g <= 1'b1;
                   state <= 2'b11;
               end
               else if ((x == 1'b0) && (posedge clk))
               begin
                   f <= 1'b0;
                   g <= 1'b0;
                   if ((y == 1'b1) && (posedge clk))
                       state <= 2'b11;
                   else
                       state <= 2'b11;
               end
            end
         endcase
      end
   end
endmodule
