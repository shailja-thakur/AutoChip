module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  reg [3:0] tens_hh;
  reg [3:0] ones_hh;
  reg [3:0] tens_mm;
  reg [3:0] ones_mm;
  reg [3:0] tens_ss;
  reg [3:0] ones_ss;

  always @(posedge clk) begin
    if (reset) begin
      tens_hh <= 4'b0001;
      ones_hh <= 4'b0010;
      tens_mm <= 4'b0000;
      ones_mm <= 4'b0000;
      tens_ss <= 4'b0000;
      ones_ss <= 4'b0000;
    end else if (ena) begin
      ones_ss <= ones_ss + 1;
      if (ones_ss > 9) begin
        ones_ss <= 4'b0000;
        tens_ss <= tens_ss + 1;
        if (tens_ss > 5) begin
          tens_ss <= 4'b0000;
          ones_mm <= ones_mm + 1;
          if (ones_mm > 9) begin
            ones_mm <= 4'b0000;
            tens_mm <= tens_mm + 1;
            if (tens_mm > 5) begin
              tens_mm <= 4'b0000;
              ones_hh <= ones_hh + 1;
              if (ones_hh > 2'b0100) begin
                ones_hh <= 4'b0001;
                tens_hh <= tens_hh + 1;
                if (tens_hh > 2'b0001) begin
                  tens_hh <= 4'b0000;
                end
              end
            end
          end
        end
      end
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      pm <= 1'b0;
    end else if (tens_hh >= 2'b0011) begin
      pm <= 1'b1;
    end else begin
      pm <= 1'b0;
    end
  end

  assign hh = {tens_hh, ones_hh};
  assign mm = {tens_mm, ones_mm};
  assign ss = {tens_ss, ones_ss};

endmodule
