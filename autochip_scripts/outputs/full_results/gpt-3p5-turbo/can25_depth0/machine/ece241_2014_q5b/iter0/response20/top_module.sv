module top_module (
  input clk,
  input areset,
  input x,
  output z
);

  reg [1:0] state;
  always @(posedge clk or posedge areset)
  begin
    if (areset)
      state <= 2'b00;  // State A
    else
    begin
      case (state)
        2'b00:  // State A
          if (x == 1)
            state <= 2'b01;  // State B
        2'b01:  // State B
          state <= 2'b01;  // State B
      endcase
    end
  end

  assign z = (state == 2'b00 && x == 1) || (state == 2'b01 && x == 0);

endmodule
