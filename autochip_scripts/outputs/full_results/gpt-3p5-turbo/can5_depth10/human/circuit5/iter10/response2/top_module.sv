module top_module (
  input [3:0] a, 
  input [3:0] b, 
  input [3:0] c, 
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);
  
always @(*) begin
    case({a,b,c,d,e})
        5'b00011: q = 4'b0010;
        5'b00101: q = 4'b1110;
        5'b01001: q = 4'b0001;
        5'b01011: q = 4'b1101;
        5'b01110: q = 4'b0010;
        5'b10000: q = 4'b1111;
        default: q = 4'b1111;
    endcase
end

endmodule
