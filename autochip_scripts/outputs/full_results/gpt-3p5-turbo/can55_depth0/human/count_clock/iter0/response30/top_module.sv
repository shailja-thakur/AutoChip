module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hh <= 8'b00010010; // initialize hh to "12"
      mm <= 8'b00000000; // initialize mm to "00"
      ss <= 8'b00000000; // initialize ss to "00"
      pm <= 1'b0; // initialize pm to AM
    end else begin
      if (ena) begin
        ss <= ss + 1; // increment seconds
        if (ss == 8'b00111010) begin // if ss reaches "60"
          ss <= 8'b00000000; // reset ss
          mm <= mm + 1; // increment minutes
          if (mm == 8'b01100000) begin // if mm reaches "60"
            mm <= 8'b00000000; // reset mm
            hh <= hh + 1; // increment hours
            if (hh == 8'b00011001) begin // if hh reaches "13"
              hh <= 8'b00000001; // reset hh to "01"
              pm <= ~pm; // toggle pm (AM/PM)
            end
          end
        end
      end
    end
  end

endmodule
