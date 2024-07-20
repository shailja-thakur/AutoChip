module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  always @(posedge clk) begin
    if (reset) begin
      pm <= 0;
      hh <= 8'b0001; // Set hours to 12 (BCD: 0001)
      mm <= 8'b0000; // Set minutes to 00 (BCD: 0000)
      ss <= 8'b0000; // Set seconds to 00 (BCD: 0000)
    end else if (ena) begin
      if ((ss == 8'b0101 && mm == 8'b0101 && hh[3:2] == 2'b01) || // If it's 11:59 PM, reset to 12:00 AM
          (ss == 8'b0101 && mm == 8'b0101 && hh[3:2] == 2'b00)) begin // If it's 11:59 AM, reset to 12:00 PM
        pm <= ~pm; // Toggle am/pm indicator
        hh <= hh + 1; // Increment hours
      end
      
      ss <= ss + 1; // Increment seconds
      
      if (ss == 8'b0110) begin // If it's 10 seconds, reset seconds to 00 and increment minutes
        ss <= 8'b0000;
        mm <= mm + 1; // Increment minutes
        
         if (mm == 8'b0101) begin // If it's 59 minutes, reset minutes to 00 and increment hours
           mm <=  8'b0000;
  
           if (hh[3:2] == 2'b00 && hh[1:0] == 8'b0000) begin // If it's 12:00 AM, reset hours to 12 (12:00 PM)
             hh <= 8'b1100;
           end else if (hh[3:2] == 2'b01 && hh[1:0] == 8'b0000) begin // If it's 12:00 PM, reset hours to 12 (12:00 AM)
             hh <= 8'b0001;
           end else if (hh[1:0] == 8'b0101) begin // If it's 09:00, increment hours
             hh <= hh + 1;
           end
         end
       end
     end
   end
endmodule
