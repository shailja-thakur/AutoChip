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
      hh <= 8'b00010010; // set hh to "12"
      mm <= 8'b00000000; // set mm to "00"
      ss <= 8'b00000000; // set ss to "00"
      pm <= 1'b0; // set pm to AM
    end else if (ena) begin
      ss <= ss + 1; // increment ss by 1
      if (ss >= 60) begin
        ss <= 8'b00000000; // reset ss to "00"
        mm <= mm + 1; // increment mm by 1
        if (mm >= 60) begin
          mm <= 8'b00000000; // reset mm to "00"
          hh <= hh + 1; // increment hh by 1
          if (hh >= 12) begin
            hh <= 8'b00010000; // reset hh to "01"
            pm <= ~pm; // toggle pm (AM to PM or PM to AM)
          end
        end
      end
    end
  end

endmodule
