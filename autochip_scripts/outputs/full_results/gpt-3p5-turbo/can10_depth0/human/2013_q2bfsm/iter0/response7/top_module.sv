module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);

  reg [1:0] state;
  reg next_f;
  reg next_g;

  always @(posedge clk or negedge resetn) begin
    if (~resetn)
      state <= 2'b00;
    else
      state <= next_state;
  end

  always @(state or x or y) begin
    case (state)
      2'b00: begin  // state A
        next_f = 1'b0;
        next_g = 1'b0;
        if (resetn && ~x)
          state = 2'b01;
      end
      2'b01: begin  // state B
        next_f = 1'b1;
        next_g = 1'b0;
        if (resetn && ~x)
          state = 2'b10;
        else if (x)
          state = 2'b00;
      end
      2'b10: begin  // state C
        next_f = 1'b0;
        next_g = 1'b0;
        if (resetn && ~x && g)
          state = 2'b11;
        else if (~x)
          state = 2'b00;
      end
      2'b11: begin  // state D
        next_f = 1'b0;
        next_g = y ? 1'b1 : 1'b0;
        if (~y)
          state = 2'b00;
      end
      default: begin
        next_f = 1'b0;
        next_g = 1'b0;
        state = 2'b00;
      end
    endcase
  end

  always @(posedge clk) begin
    f <= next_f;
    g <= next_g;
  end

endmodule
