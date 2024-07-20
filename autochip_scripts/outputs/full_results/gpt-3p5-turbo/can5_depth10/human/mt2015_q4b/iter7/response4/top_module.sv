module top_module(
  input x,
  input y,
  output z);

  reg [1:0] state;
  wire z_reg;
  
  always @(posedge x or posedge y) begin
    case(state)
      2'b00: begin
        if (x & !y)
          state <= 2'b01;
        else
          state <= 2'b00;
      end
      2'b01: begin
        if (!x)
          state <= 2'b10;
        else
          state <= 2'b00;
      end
      2'b10: begin
        if (y)
          state <= 2'b11;
        else
          state <= 2'b00;
      end
      2'b11: begin
        if (!y)
          state <= 2'b00;
        else
          state <= 2'b11;
      end
      default: state <= 2'b00;
    endcase
  end

  assign z_reg = (state == 2'b10) | (state == 2'b11);
  assign z = z_reg;

endmodule
