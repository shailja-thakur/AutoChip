module top_module (
  input [6:1] y,
  input w,
  output reg Y2,
  output reg Y4
);


  assign Y2 = y[1] & ~w;
  
  always @(*)
    begin
        Y4 =  (y[6:5]==2'b11) && (y[3:2]==2'b11) && w;
    end
endmodule
