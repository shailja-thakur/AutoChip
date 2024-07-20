module top_module (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
); 

reg [3:0] state, next_state;

parameter B = 1'b0;
parameter C = 1'b1;
parameter S10 = 2'b00;
parameter S11 = 2'b01;
parameter S20 = 2'b10;
parameter S21 = 2'b11;

always @(posedge clk or posedge reset) begin
  if (reset)
    state <= B;
  else
    state <= next_state;
end

always @* begin
  case (state)
    B: begin
      if (s)
        next_state = C;
      else if (w)
        next_state = S11;
      else
        next_state = S10;
    end
    C: begin
      if (w)
        next_state = S11;
      else
        next_state = S10;
    end
    S10: begin
      if (w)
        next_state = S21;
      else
        next_state = S20;
    end
    S11: begin
      if (w)
        next_state = S22;
      else
        next_state = S21;
    end
    S20: begin
      next_state = B;
    end
    S21: begin
      if (w)
        next_state = C;
      else
        next_state = B;
    end
    S22: begin
      if (w)
        next_state = B;
      else
        next_state = C;
    end
  endcase
end

always @(posedge clk) begin
  if (state == S20 && s)
    z <= 1'b1;
  else
    z <= 1'b0;
end

endmodule
