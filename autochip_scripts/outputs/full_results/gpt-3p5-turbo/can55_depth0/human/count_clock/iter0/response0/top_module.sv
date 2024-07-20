module top_module(
   input clk,
   input reset,
   input ena,
   output reg pm,
   output reg [7:0] hh,
   output reg [7:0] mm,
   output reg [7:0] ss);

   reg [7:0] counter;

   always @(posedge clk or posedge reset) begin
      if (reset) begin
         counter <= 0;
         pm <= 0;
         hh <= 8'h01;
         mm <= 8'h00;
         ss <= 8'h00;
      end else if (ena) begin
         counter <= counter + 1;

         if (counter == 50000) begin
            counter <= 0;

            if (ss == 8'h59) begin
               ss <= 8'h00;

               if (mm == 8'h59) begin
                  mm <= 8'h00;

                  if (hh == 8'h12) begin
                     hh <= 8'h01;
                     pm <= ~pm;
                  end else begin
                     hh <= hh + 1;
                  end
               end else begin
                  mm <= mm + 1;
               end
            end else begin
               ss <= ss + 1;
            end
         end
      end
   end
   
endmodule
