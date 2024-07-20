module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

  // Define the states
  typedef enum logic [2:0] {
    A,
    B,
    C,
    D
  } state_t;
  
  // Declare state and next_state registers
  reg state_t state, next_state;
  
  // Declare counter reg
  reg [1:0] counter;
  
  // Assign initial state and next_state values
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= A;
      next_state <= A;
      counter <= 0; // Clearing the counter in reset state
    end else begin
      state <= next_state;
      counter <= counter + 1;
    end
  end
  
  // Define the state transitions and output logic
  always @(state, w, counter) begin
    next_state = state;
    case(state)
      A: begin
        if (s)
          next_state = B;
        else
          next_state = A;
      end
      B: begin
        if (counter == 0 && w)
          next_state = C;
        else if (counter == 1 && w)
          next_state = D;
        else if (counter == 2 && w)
          next_state = D;
        else
          next_state = B;
      end
      C: begin
        if (counter == 2) begin
          if (w == 2'b01) // Changed w to 2'b01
            next_state = B;
          else
            next_state = A;
        end else
          next_state = C;
      end
      D: begin
        if (counter == 2) begin
          if (w == 2'b01) // Changed w to 2'b01
            next_state = A;
          else
            next_state = A;
        end else
          next_state = D;
      end
    endcase
  end
  
  // Assign output z based on state
  always @(posedge clk) begin
    case(state)
      B, C: z <= 1;
      default: z <= 0;
    endcase
  end
endmodule
