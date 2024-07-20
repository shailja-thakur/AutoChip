module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss);

  reg [3:0] hour_count;
  reg [5:0] min_count;
  reg [5:0] sec_count;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hour_count <= 4'b1100;
      min_count <= 6'b000000;
      sec_count <= 6'b000000;
      pm <= 1'b0;
    end else if (ena) begin
      sec_count <= sec_count + 1;
      if (sec_count == 6'b011000) begin
        sec_count <= 6'b000000;
        min_count <= min_count + 1;
        if (min_count == 6'b110000) begin
          min_count <= 6'b000000;
          hour_count <= hour_count + 1;
          if (hour_count == 4'b1101) begin
            hour_count <= 4'b0001;
            pm <= ~pm;
          end else if (hour_count == 4'b1100) begin
            hour_count <= 4'b0000;
            pm <= ~pm;
          end
        end
      end
    end
  end

  always @(posedge reset) begin
    if (reset) begin
      hh <= 8'b00000001;
      mm <= 8'b00000000;
      ss <= 8'b00000000;
    end
  end

  always @(posedge ena) begin
    if (ena) begin
      hh <= {pm, hour_count};
      mm <= min_count;
      ss <= sec_count;
    end
  end

endmodule
