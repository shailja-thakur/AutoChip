module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss);
  
  reg [4:0] hour_count;
  reg [6:0] min_count;
  reg [6:0] sec_count;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hour_count <= 5'b00000;
      min_count <= 7'b0000000;
      sec_count <= 7'b0000000;
      pm <= 1'b0;
    end else if (ena) begin
      sec_count <= sec_count + 1;
      if (sec_count == 7'b0110000) begin
        sec_count <= 7'b0000000;
        min_count <= min_count + 1;
        if (min_count == 7'b1100000) begin
          min_count <= 7'b0000000;
          hour_count <= hour_count + 1;
          if (hour_count == 5'b10111) begin
            hour_count <= 5'b00000;
            pm <= ~pm;
          end else if (hour_count == 5'b10110) begin
            hour_count <= 5'b00001;
            pm <= ~pm;
          end
        end
      end
    end
  end
  
  always @(posedge reset) begin
    if (reset) begin
      hh <= 8'b00010010;
      mm <= 8'b00000000;
      ss <= 8'b00000000;
    end
  end
  
  always @(posedge ena) begin
    if (ena) begin
      hh <= {pm, hour_count};
      mm <= min_count[5:0];
      ss <= sec_count[5:0];
    end
  end
  
endmodule
