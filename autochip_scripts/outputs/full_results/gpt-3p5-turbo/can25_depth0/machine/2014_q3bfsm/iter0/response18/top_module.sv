module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);

reg [2:0] state, next_state; // internal state and next state

parameter A = 3'b000; // define the state values
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= A; // initialize state to A when reset is high
  end else begin
    state <= next_state; // update state based on next_state
  end
end

always @* begin
  case(state)
    A: begin
      if (x) begin
        next_state = B; // if state is A and x is high, next state is B
      end else begin
        next_state = A; // if state is A and x is low, next state is still A
      end
    end
    B: begin
      if (x) begin
        next_state = E; // if state is B and x is high, next state is E
      end else begin
        next_state = B; // if state is B and x is low, next state is still B
      end
    end
    C: begin
      if (x) begin
        next_state = B; // if state is C and x is high, next state is B
      end else begin
        next_state = C; // if state is C and x is low, next state is still C
      end
    end
    D: begin
      if (x) begin
        next_state = C; // if state is D and x is high, next state is C
      end else begin
        next_state = B; // if state is D and x is low, next state is B
      end
    end
    E: begin
      if (x) begin
        next_state = E; // if state is E and x is high, next state is E
      end else begin
        next_state = D; // if state is E and x is low, next state is D
      end
    end
    default: begin
      next_state = A; // default case, if none of the above states match, next state is A
    end
  endcase
end

always @(state) begin
  case(state)
    D, E: begin
      z = 1'b1; // set output to high when state is D or E
    end
    default: begin
      z = 1'b0; // set output to low for all other states
    end
  endcase
end

endmodule
