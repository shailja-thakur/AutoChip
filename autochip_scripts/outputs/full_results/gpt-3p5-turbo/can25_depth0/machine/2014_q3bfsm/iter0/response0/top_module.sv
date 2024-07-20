module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);
  
  reg [2:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 3'b000; // initialize state to A
    else begin
      case (state)
        3'b000: // state A
          begin
            if (x)
              state <= 3'b001; // next state is B
            else
              state <= 3'b000; // next state is A
          end
        3'b001: // state B
          begin
            if (x)
              state <= 3'b100; // next state is E
            else
              state <= 3'b001; // next state is B
          end
        3'b010: // state C
          begin
            if (x)
              state <= 3'b001; // next state is B
            else
              state <= 3'b010; // next state is C
          end
        3'b011: // state D
          begin
            if (x)
              state <= 3'b010; // next state is C
            else
              state <= 3'b001; // next state is B
          end
        3'b100: // state E
          begin
            if (x)
              state <= 3'b100; // next state is E
            else
              state <= 3'b011; // next state is D
          end
        default:
          state <= 3'b000; // default to state A
      endcase
    end
  end
  
  always @(state) begin
    if (state == 3'b100 || state == 3'b101)
      z <= 1'b1; // output is high when state is D or E
    else
      z <= 1'b0;
  end
  
endmodule
