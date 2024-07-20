module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss);

  // Internal variables
  reg [3:0] hr_tens;
  reg [3:0] hr_ones;
  reg [5:0] min_tens;
  reg [3:0] min_ones;
  reg [5:0] sec_tens;
  reg [3:0] sec_ones;

  always @(posedge clk) begin
    if (reset) begin
      pm <= 1'b0;
      hh <= 8'b00000000;
      mm <= 8'b00000000;
      ss <= 8'b00000000;
    end else if (ena) begin
      // Increment seconds
      if (sec_ones == 8'b0101) begin
        sec_ones <= 8'b0000;
  
        if (sec_tens == 6'b010101) begin
          sec_tens <= 6'b000000;
  
          // Increment minutes
          if (min_ones == 8'b0101) begin
            min_ones <= 8'b0000;
  
            if (min_tens == 6'b010101) begin
              min_tens <= 6'b000000;
  
              // Increment hours
              if (hr_ones == 8'b0001) begin
                hr_ones <= 8'b0000;
  
                if (hr_tens == 4'b0001) begin
                  hr_tens <= 4'b0000;
  
                  // Toggle AM/PM
                  pm <= ~pm;
                end else begin
                  hr_tens <= hr_tens + 4'b0001;
                end
              end else begin
                hr_ones <= hr_ones + 4'b0001;
              end
            end else begin
              min_tens <= min_tens + 6'b0001;
            end
          end else begin
            min_ones <= min_ones + 4'b0001;
          end
        end else begin
          sec_tens <= sec_tens + 6'b0001;
        end
      end else begin
        sec_ones <= sec_ones + 4'b0001;
      end
    end
  end

endmodule
