module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

	always @(posedge clk) begin
	  if (reset) begin
	    hh <= 8'h12;
	    mm <= 8'h00;
	    ss <= 8'h00;
	    pm <= 0;
	  end else if (ena) begin
	    if (ss == 8'h59) begin
	      ss <= 8'h00;
	      if (mm == 8'h59) begin
	        mm <= 8'h00;
	        if (hh == 8'h11) begin
	          hh <= 8'h12;
	          pm <= ~pm;
	        end else begin
	          hh <= hh + 1;
	        end
	      end else begin
	        mm <= mm + 1;
	      end
	    end else begin
	      ss <= ss + 1;
	    end
	  end
	end

endmodule
