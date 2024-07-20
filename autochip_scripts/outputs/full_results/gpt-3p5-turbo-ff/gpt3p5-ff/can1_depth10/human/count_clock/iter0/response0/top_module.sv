module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss);
  
  reg [7:0] hour_count;
  reg [7:0] min_count;
  reg [7:0] sec_count;
  
  always @(posedge clk) begin
    if (reset) begin
      hour_count <= 8'h12;
      min_count <= 8'h00;
      sec_count <= 8'h00;
      pm <= 1'b0;
    end else if (ena) begin
      sec_count <= sec_count + 1;
      if (sec_count == 8'h60) begin
        sec_count <= 8'h00;
        min_count <= min_count + 1;
        if (min_count == 8'h60) begin
          min_count <= 8'h00;
          hour_count <= hour_count + 1;
          if (hour_count == 8'h13) begin
            hour_count <= 8'h01;
            pm <= ~pm;
          end else if (hour_count == 8'h12) begin
            pm <= ~pm;
          end
        end
      end
    end
  end
  
  always @(posedge reset) begin
    if (reset) begin
      hh <= 8'h12;
      mm <= 8'h00;
      ss <= 8'h00;
    end
  end
  
  always @(posedge ena) begin
    if (ena) begin
      hh <= hour_count;
      mm <= min_count;
      ss <= sec_count;
    end
  end
  
endmodule
