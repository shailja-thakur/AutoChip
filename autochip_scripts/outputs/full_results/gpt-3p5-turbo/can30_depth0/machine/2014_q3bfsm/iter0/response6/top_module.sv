module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
  if (reset == 1) begin
    state <= 3'b001; // initialize state to A
    z <= 0;
  end else begin
    case(state)
      3'b001: begin // state A
        if (x == 0)
          state <= 3'b001; // next state is A
        else
          state <= 3'b010; // next state is B
      end
      3'b010: begin // state B
        if (x == 0)
          state <= 3'b010; // next state is B
        else
          state <= 3'b101; // next state is E
      end
      3'b011: begin // state C
        if (x == 0)
          state <= 3'b011; // next state is C
        else
          state <= 3'b010; // next state is B
      end
      3'b100: begin // state D
        if (x == 0)
          state <= 3'b010; // next state is B
        else
          state <= 3'b011; // next state is C
      end
      default: begin // state E
        if (x == 0)
          state <= 3'b100; // next state is D
        else
          state <= 3'b111; // next state is E
      end
    endcase
    
    if (state == 3'b100 || state == 3'b111) // state D or E
      z <= 1;
    else
      z <= 0;
  end
end

endmodule
