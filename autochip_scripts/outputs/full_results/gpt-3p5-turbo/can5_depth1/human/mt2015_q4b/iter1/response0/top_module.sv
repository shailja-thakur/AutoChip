module top_module(
  input x,
  input y,
  output z);

  reg [1:0] state;
  initial state = 2'b00;

  always @(x, y)
  begin
    case(state)
      0:  if(x==1'b1 && y==1'b1)
            state = 2'b01;
          else
            state = 2'b00;
      1:  if(x==1'b0 && y==1'b1)
            state = 2'b10;
          else
            state = 2'b00;
      2:  if(x==1'b0 && y==1'b0)
            state = 2'b11;
          else
            state = 2'b00;
    endcase
  end

  assign z = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
