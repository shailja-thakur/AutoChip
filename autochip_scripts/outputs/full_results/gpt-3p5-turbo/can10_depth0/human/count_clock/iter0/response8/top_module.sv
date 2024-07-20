module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  reg [3:0] hour_tens;
  reg [3:0] hour_units;
  reg [3:0] min_tens;
  reg [3:0] min_units;
  reg [3:0] sec_tens;
  reg [3:0] sec_units;

  always @(posedge clk) begin
    if (reset) begin
      hour_tens <= 4'b0001;
      hour_units <= 4'b0010;
      min_tens <= 4'b0000;
      min_units <= 4'b0000;
      sec_tens <= 4'b0000;
      sec_units <= 4'b0000;
      pm <= 1'b0;
    end else if (ena) begin
      if (sec_units == 4'b1001) begin
        sec_units <= 4'b0000;
        if (sec_tens == 4'b1001) begin
          sec_tens <= 4'b0000;
          if (min_units == 4'b1001) begin
            min_units <= 4'b0000;
            if (min_tens == 4'b0101) begin
              min_tens <= 4'b0000;
              if (hour_units == 4'b1001) begin
                hour_units <= 4'b0000;
                if (hour_tens == 4'b0001) begin
                  hour_tens <= 4'b0000;
                  pm <= ~pm;
                end else begin
                  hour_tens <= hour_tens + 1;
                end
              end else begin
                hour_units <= hour_units + 1;
              end
            end else begin
              min_tens <= min_tens + 1;
            end
          end else begin
            min_units <= min_units + 1;
          end
        end else begin
          sec_tens <= sec_tens + 1;
        end
      end else begin
        sec_units <= sec_units + 1;
      end
    end
  end

  assign hh = {hour_tens, hour_units};
  assign mm = {min_tens, min_units};
  assign ss = {sec_tens, sec_units};

endmodule
