module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss);
  
  reg [7:0] hh_count;
  reg [7:0] mm_count;
  reg [7:0] ss_count;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      hh_count <= 8'b00000000;
      mm_count <= 8'b00000000;
      ss_count <= 8'b00000000;
      pm <= 0;
    end
    else if (ena) begin
      ss_count <= ss_count + 1;
      if (ss_count == 8'b01101000) begin // 60 in BCD
        ss_count <= 8'b00000000;
        mm_count <= mm_count + 1;
        if (mm_count == 8'b01101000) begin // 60 in BCD
          mm_count <= 8'b00000000;
          hh_count <= hh_count + 1;
          if (hh_count == 8'b00011010) begin // 24 in BCD
            hh_count <= 8'b00000000;
            pm <= ~pm;
          end
        end
      end
    end
  end
  
  // BCD conversion modules (not provided)
  
  // Connect BCD conversion modules to outputs
  // Example: hh = bcd2bin(hh_count);
  
endmodule
