module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

  reg [7:0] hh_next;
  reg [7:0] mm_next;
  reg [7:0] ss_next;
  reg [3:0] hours;
  reg [5:0] minutes;
  reg [5:0] seconds;
  
  always @(posedge clk) begin
    if (reset) begin
      hh <= 8'b00010010;  // Set initial value to 12 AM
      mm <= 8'b00000000;
      ss <= 8'b00000000;
      pm <= 1'b0;
    end else if (ena) begin      
      seconds = ss + 1;
      minutes = mm;
      hours = hh;
      
      if (seconds == 6'd59) begin
        seconds <= 6'd0;
        minutes <= minutes + 1;

        if (minutes == 6'd59) begin
          minutes <= 6'd0;
          hours <= hours + 1;

          if (hours == 4'd12) begin
            hours <= 4'd1;
            pm <= ~pm;  // Toggle AM/PM indicator
          end else if (hours == 4'd13) begin
            hours <= 4'd1;
            pm <= ~pm;  // Toggle AM/PM indicator
          end
        end
      end
      
      ss <= seconds;
      mm <= minutes;
      hh <= hours;
    end
  end

endmodule
