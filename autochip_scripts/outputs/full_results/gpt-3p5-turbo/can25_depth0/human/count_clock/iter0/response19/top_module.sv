module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  reg [3:0] sec_ctr;
  reg [3:0] min_ctr;
  reg [3:0] hour_ctr;

  always @(posedge clk) begin
    if (reset) begin      
      sec_ctr <= 4'd0;
      min_ctr <= 4'd0;
      hour_ctr <= 4'd0;
      pm <= 1'b0;
      hh <= 8'b0;
      mm <= 8'b0;
      ss <= 8'b0;
    end else if (ena) begin
      sec_ctr <= sec_ctr + 1;
      if (sec_ctr == 4'd9) begin
        sec_ctr <= 4'd0;
        min_ctr <= min_ctr + 1;
        if (min_ctr == 4'd59) begin
          min_ctr <= 4'd0;
          hour_ctr <= hour_ctr + 1;
          if (hour_ctr == 4'd12) begin
            hour_ctr <= 4'd0;
            pm <= ~pm;
          end
        end
      end
    end
  end

  always @(posedge clk) begin
    if (reset) begin      
      hh <= 8'b0;
      mm <= 8'b0;
      ss <= 8'b0;
    end else if (ena) begin
      if (sec_ctr == 4'd0) begin
        ss <= ss + 1;
        if (ss == 8'd59) begin
          ss <= 8'b0;
          mm <= mm + 1;
          if (mm == 8'd59) begin
            mm <= 8'b0;
            hh <= hh + 1;
            if (hh == 8'd11) begin
              hh <= 8'b0;
              if (pm) begin
                pm <= 1'b0;
              else
                pm <= 1'b1;
              end
            end
          end
        end
      end
    end
  end

endmodule
