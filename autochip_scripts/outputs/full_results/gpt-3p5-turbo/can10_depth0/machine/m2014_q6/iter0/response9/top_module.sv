module top_module (
  input clk,
  input reset,
  input w,
  output z
);
  
  reg [2:0] state_reg, state_next;
  wire clk_b;
  assign clk_b = ~clk;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state_reg <= 3'b000;
    else
      state_reg <= state_next;
  end
  
  always @(state_reg or w) begin
    case(state_reg)
      3'b000: begin  // state A
        if (w)
          state_next = 3'b000;  // stay in state A
        else
          state_next = 3'b001;  // transition from A to B
      end
      3'b001: begin  // state B
        if (w)
          state_next = 3'b011;  // transition from B to D
        else
          state_next = 3'b010;  // transition from B to C
      end
      3'b010: begin  // state C
        if (w)
          state_next = 3'b011;  // transition from C to D
        else
          state_next = 3'b100;  // transition from C to E
      end
      3'b011: begin  // state D
        if (w)
          state_next = 3'b000;  // transition from D to A
        else
          state_next = 3'b101;  // transition from D to F
      end
      3'b100: begin  // state E
        if (w)
          state_next = 3'b011;  // transition from E to D
        else
          state_next = 3'b100;  // stay in state E
      end
      3'b101: begin  // state F
        if (w)
          state_next = 3'b011;  // transition from F to D
        else
          state_next = 3'b010;  // transition from F to C
      end
      default: state_next = 3'b000;
    endcase
  end
  
  always @(state_reg) begin
    if (state_reg == 3'b100 || state_reg == 3'b101)
      z = 1'b1;
    else
      z = 1'b0;
  end

endmodule
