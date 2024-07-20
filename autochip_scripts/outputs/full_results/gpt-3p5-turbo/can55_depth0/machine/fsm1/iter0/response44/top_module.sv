module top_module (
	input clk,
	input in,
	input areset,
	output out
);
  reg [1:0] state, next_state;
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b1;
    else
      state <= next_state;
  end
  
  always @(state, in) begin
    case(state)
      2'b00: begin
        if (in)
          next_state <= 2'b00;
        else
          next_state <= 2'b01;
      end
      2'b01: begin
        if (in)
          next_state <= 2'b01;
        else
          next_state <= 2'b00;
      end
      default: begin
        next_state <= 2'b00;
      end
    endcase
  end
  
  assign out = (state == 2'b01) ? 1'b1 : 1'b0;
  
endmodule
