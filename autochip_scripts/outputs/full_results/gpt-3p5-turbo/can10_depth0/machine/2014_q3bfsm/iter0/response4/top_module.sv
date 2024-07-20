module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);
reg [2:0] state;
wire next_state;

always @(posedge clk or posedge reset) begin
  if (reset)
    state <= 3'b000; // Initializing the state to A
  else
    state <= next_state;
end

always @* begin
  case(state)
    3'b000: begin // State A
      if (x)
        next_state = 3'b001; // Next state is B
      else
        next_state = 3'b000; // Next state is A
    end

    3'b001: begin // State B
      if (x)
        next_state = 3'b100; // Next state is E
      else
        next_state = 3'b001; // Next state is B
    end

    3'b010: begin // State C
      if (x)
        next_state = 3'b001; // Next state is B
      else
        next_state = 3'b010; // Next state is C
    end

    3'b011: begin // State D
      if (x)
        next_state = 3'b010; // Next state is C
      else
        next_state = 3'b001; // Next state is B
    end

    3'b100: begin // State E
      if (x)
        next_state = 3'b100; // Next state is E
      else
        next_state = 3'b011; // Next state is D
    end

    default: next_state = 3'b000; // Default state is A
  endcase
end

always @(posedge clk or posedge reset) begin
  if (reset)
    z <= 1'b0;
  else begin
    if (state == 3'b100 || state == 3'b101)
      z <= 1'b1;
    else
      z <= 1'b0;
  end
end

endmodule
