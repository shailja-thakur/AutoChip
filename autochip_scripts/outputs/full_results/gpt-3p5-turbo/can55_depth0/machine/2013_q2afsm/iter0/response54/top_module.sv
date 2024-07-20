module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

  reg [3:1] state;
  reg [3:1] next_state;

  always @(posedge clk)
  begin
    if (~resetn)
      state <= 3'b001; // Set state to A
    else
      state <= next_state; // Set state to the next state
  end

  always @*
  begin
    case (state)
      3'b001: // State A
        begin
          if (r[1])
            next_state = 3'b010; // Next state is B
          else if (r[2])
            next_state = 3'b011; // Next state is C
          else if (r[3])
            next_state = 3'b100; // Next state is D
          else
            next_state = 3'b001; // Next state is A
        end

      3'b010: // State B
        begin
          if (r[1])
            next_state = 3'b010; // Next state is B
          else
            next_state = 3'b001; // Next state is A
        end

      3'b011: // State C
        begin
          if (r[2])
            next_state = 3'b011; // Next state is C
          else
            next_state = 3'b001; // Next state is A
        end

      3'b100: // State D
        begin
          if (r[3])
            next_state = 3'b100; // Next state is D
          else
            next_state = 3'b001; // Next state is A
        end
    endcase
  end

  assign g[1] = (state == 3'b010) ? 1 : 0; // Set g[1] high if current state is B
  assign g[2] = (state == 3'b011) ? 1 : 0; // Set g[2] high if current state is C
  assign g[3] = (state == 3'b100) ? 1 : 0; // Set g[3] high if current state is D

endmodule
