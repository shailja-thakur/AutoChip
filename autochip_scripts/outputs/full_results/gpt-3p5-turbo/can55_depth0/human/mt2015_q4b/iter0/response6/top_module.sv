module top_module(
    input x,
    input y,
    output z);

  reg [1:0] state;

  always @(x, y) begin
    case(state)
      0: begin
        if(x == 1'b1 && y == 1'b0)
          state <= 1;
        else
          state <= 0;
      end
      1: begin
        state <= 2;
      end
      2: begin
        if(y == 1'b1 && x == 1'b0)
          state <= 3;
        else
          state <= 2;
      end
      3: begin
        if(x == 1'b0 && y == 1'b0)
          state <= 4;
        else
          state <= 3;
      end
      4: begin
        if(x == 1'b1 && y == 1'b1)
          state <= 5;
        else
          state <= 4;
      end
      5: begin
        state <= 4;
      end
    endcase
  end

  assign z = (state == 4);

endmodule
