module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  reg [7:0] hour_count;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hh <= 8'b00010010; // reset hh to 12
      mm <= 8'b00000000; // reset mm to 00
      ss <= 8'b00000000; // reset ss to 00
      pm <= 1'b0; // reset pm to AM
      hour_count <= 8'b00010010; // reset hour_count to 12
    end else if (ena) begin
      ss <= ss + 1; // increment seconds
      if (ss == 8'b01100010) begin // 59
        ss <= 8'b00000000; // reset seconds to 00
        mm <= mm + 1; // increment minutes
        if (mm == 8'b01100010) begin // 59
          mm <= 8'b00000000; // reset minutes to 00
          hh <= hh + 1; // increment hours
          hour_count <= hour_count + 1; // increment hour_count
          if (hour_count == 8'b00010100) begin // 12
            hour_count <= 8'b00000000; // reset hour_count to 0
            pm <= ~pm; // toggle am/pm indicator
          end
        end
      end
    end
  end

endmodule
