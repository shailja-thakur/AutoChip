module top_module (
    input clk,
    input wire in,
    input wire areset,
    output wire out
);

  reg [1:0] state, next_state;
  initial begin
    state = 2'b00;
    next_state = 2'b00;
  end
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b01;
    else
      state <= next_state;
  end
  
  always @(state, in) begin
    case (state)
      2'b00: begin
        if (in)
          next_state = 2'b00;
        else
          next_state = 2'b01;
      end
      2'b01: begin
        if (in)
          next_state = 2'b01;
        else
          next_state = 2'b00;
      end
    endcase
  end
  
  assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
