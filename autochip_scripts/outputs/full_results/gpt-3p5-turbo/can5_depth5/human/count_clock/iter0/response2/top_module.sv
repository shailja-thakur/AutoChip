module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss);

  always @(posedge clk) begin
    if (reset)
      begin
        pm <= 0;
        hh <= 8'b0001; // 12 in BCD format
        mm <= 8'b0000;
        ss <= 8'b0000;
      end
    else if (ena)
      begin
        ss <= ss + 1;
        if (ss == 8'b0110) // if seconds reach 60
          begin
            ss <= 8'b0000;
            mm <= mm + 1;
            if (mm == 8'b0110 && hh[3:2] == 2'b01) // if minutes reach 60 and hour is 12
              begin
                mm <= 8'b0000;
                hh <= 8'b0001; // reset to 12
                pm <= ~pm; // toggle am/pm
              end
            else if (mm == 8'b0110) // if minutes reach 60
              begin
                mm <= 8'b0000;
                hh <= hh + 1; // increment hour
              end
          end
      end
  end

endmodule
