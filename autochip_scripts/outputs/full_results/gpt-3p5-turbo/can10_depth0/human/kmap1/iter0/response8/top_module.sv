module top_module(
  input a, 
  input b,
  input c,
  output out
);
  reg out;
  
  always @(a or b or c)
  begin
    case ({a,b,c})
      3'b000, 3'b001:
        out = 1'b0;
      3'b010, 3'b011, 3'b100, 3'b101:
        out = 1'b1;
      3'b110, 3'b111:
        out = 1'b1;
      default:
        out = 1'b0;
    endcase
  end
endmodule
