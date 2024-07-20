module top_module(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss);
  
  reg [7:0] counter;
  reg [7:0] next_counter;
  
  always @(posedge clk) begin
    if (reset) begin
      counter <= 8'h60;
      pm <= 1'b0;
    end 
    else if (ena) begin
      if (counter == 8'h99) begin
        counter <= 8'h00;
        pm <= ~pm;
      end
      else begin
        counter <= counter + 8'h01;
      end
    end
  end
  
  always @(posedge clk) begin
    if (reset) begin
      hh <= 8'h01;
      mm <= 8'h00;
      ss <= 8'h00;
    end 
    else if (ena) begin
      if (counter == 8'h00) begin
        if (hh == 8'h12) begin
          hh <= 8'h01;
        end
        else begin
          hh <= hh + 8'h01;
        end
      end
      
      if (counter[3:0] == 4'h09) begin
        if (mm == 8'h59) begin
          mm <= 8'h00;
        end
        else begin
          mm <= mm + 8'h01;
        end
      end
      
      if (counter[3:0] == 8'h59) begin
        if (ss == 8'h59) begin
          ss <= 8'h00;
        end
        else begin
          ss <= ss + 8'h01;
        end
      end
    end
  end
  
endmodule
