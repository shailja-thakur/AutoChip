module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);

  reg [3:0] state, next_state;

  assign f = (state == 2'b01) ? 1'b1 : 1'b0;
  assign g = (state == 2'b10 || state == 2'b11 || state == 2'b100) ? 1'b1 : 1'b0;

  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      state <= 2'b00;
    else
      state <= next_state;
  end

  always @* begin
    case (state)
      2'b00: begin
        if (x)
          next_state = 2'b10;
        else
          next_state = 2'b00;
      end
      2'b01: begin
        if (x)
          next_state = 2'b01;
        else
          next_state = 2'b100;
      end
      2'b10: begin
        if (x)
          next_state = 2'b100;
        else
          next_state = 2'b00;
      end
      2'b11: begin
        if (y)
          next_state = 2'b100;
        else
          next_state = 2'b1000;
      end
      2'b100: begin
        if (y)
          next_state = 2'b100;
        else
          next_state = 2'b1000;
      end
      2'b1000: begin
        next_state = state;
      end
      default: begin
        next_state = 2'b00;
      end
    endcase
  end

endmodule
