module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss);

  reg [7:0] hh_temp;
  reg [7:0] mm_temp;
  reg [7:0] ss_temp;

  always @(posedge clk) begin
    if (reset) begin
      hh <= 8'b00010010; // initialize to 12
      mm <= 8'b00000000;
      ss <= 8'b00000000;
      pm <= 1'b0; // initialize to AM
    end
    else if (ena) begin
      ss_temp <= ss_temp + 1;
      
      if (ss_temp == 8'b01111010) begin // 59 in BCD
        ss_temp <= 8'b00000000;
        mm_temp <= mm_temp + 1;
        
        if (mm_temp == 8'b01111010) begin // 59 in BCD
          mm_temp <= 8'b00000000;
          hh_temp <= hh_temp + 1;
          
          if (hh_temp == 8'b00011010) begin // 12 in BCD
            hh_temp <= 8'b00000001;
            
            if (pm)
              pm <= 1'b0; // change to AM if currently PM
            else
              pm <= 1'b1; // change to PM if currently AM
          end
        end
      end
    end
  end
  
  always @(posedge clk) begin
    hh <= hh_temp;
    mm <= mm_temp;
    ss <= ss_temp;
  end

endmodule
