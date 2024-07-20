module top_module(
  input wire [3:1] y,
  input wire w,
  output reg Y2);

  always @(y or w) // Fix
  begin
    case (y)
      3'b000: Y2 = 1'b0; 
      3'b001: Y2 = (w == 1'b0) ? 1'b1 : 1'b0;
      3'b010: Y2 = (w == 1'b0) ? 1'b0 : 1'b1; // Fix
      3'b011: Y2 = (w == 1'b0) ? 1'b0 : 1'b1; 
      3'b100: Y2 = (w == 1'b0) ? 1'b1 : 1'b1; 
      3'b101: Y2 = (w == 1'b0) ? 1'b1 : 1'b0;
      default: Y2 = 1'b0;
    endcase
  end
   
endmodule
