module top_module(
  input clk,
  input slowena,
  input reset,
  output reg [3:0] q);
  
  always @(posedge clk) begin
    if (reset) begin
      q <= 4'b0000;
    end else if (slowena) begin
      case (q)
        4'b1001: q <= 4'b0000;
        default: q <= q + 1;
      endcase
    end
  end
 
endmodule
