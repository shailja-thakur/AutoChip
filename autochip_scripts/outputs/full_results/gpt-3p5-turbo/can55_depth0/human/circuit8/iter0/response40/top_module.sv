module top_module (
  input clock,
  input a,
  output reg p,
  output reg q
);

  reg [2:0] state;

  always @(posedge clock) begin
    case (state)
      0: begin
        p <= 0;
        q <= 0;
        if (a == 1)
          state <= 1;
      end
      1: begin
        if (a == 0)
          state <= 2;
      end
      2: begin
        p <= 1;
        if (a == 1)
          state <= 3;
      end
      3: begin
        if (a == 0)
          state <= 4;
      end
      4: begin
        p <= 1;
        q <= 1;
        if (a == 1)
          state <= 5;
      end
      5: begin
        if (a == 0)
          state <= 6;
      end
      6: begin
        p <= 0;
        if (a == 1)
          state <= 7;
      end
      7: begin
        if (a == 0)
          state <= 8;
      end
      8: begin
        p <= 1;
        if (a == 0)
          state <= 9;
      end
      9: begin
        p <= 0;
        q <= 1;
        if (a == 1)
          state <= 10;
      end
      10: begin
        if (a == 0)
          state <= 11;
      end
      11: begin
        p <= 0;
        q <= 0;
        if (a == 1)
          state <= 12;
      end
      12: begin
        if (a == 0)
          state <= 13;
      end
      13: begin
        p <= 0;
        q <= 0;
        if (a == 1)
          state <= 14;
      end
      14: begin
        if (a == 0)
          state <= 0;
      end
      default: state <= 0;
    endcase
  end
endmodule
