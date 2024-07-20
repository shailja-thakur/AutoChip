module top_module (
  input [3:0] a, 
  input [3:0] b, 
  input [3:0] c, 
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);

always @* begin
  case ({a, b, c, d, e})
    15'd298: q = 4'b1011;
    15'd303: q = 4'd14;
    15'd308: q = 4'd11;
    15'd313: q = 4'd15;
    15'd318: q = 4'd15;
    15'd323: q = 4'd15;
    15'd328: q = 4'd15;
    15'd333: q = 4'd15;
    15'd338: q = 4'd15;
    15'd343: q = 4'd15;
    15'd348: q = 4'd15;
    15'd353: q = 4'd15;
    15'd358: q = 4'd15;
    15'd363: q = 4'd15;
    15'd368: q = 4'd15;
    default: q = 4'd15;
  endcase
end

endmodule
