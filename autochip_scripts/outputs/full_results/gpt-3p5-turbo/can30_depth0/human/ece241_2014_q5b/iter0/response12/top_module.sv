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
      state <= 2'b00;
    else
    begin
      case (state)
        2'b00: if (x) state <= 2'b01; else state <= 2'b00;
        2'b01: if (x) state <= 2'b11; else state <= 2'b10;
        2'b10: state <= 2'b11;
        2'b11: state <= 2'b10;
      endcase
    end
  end
  
  assign z = (state == 2'b01 || state == 2'b10) ? 1'b1 : 1'b0;

endmodule
