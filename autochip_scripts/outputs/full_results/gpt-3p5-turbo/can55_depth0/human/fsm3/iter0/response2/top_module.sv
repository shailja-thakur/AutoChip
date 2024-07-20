module top_module (
  input clk,
  input in,
  input areset,
  output reg out
);

  // Define the states
  typedef enum logic [1:0] {
    A,
    B,
    C,
    D
  } state_t;

  // Declare the state and next_state variables
  reg state_t state, next_state;
  
  // Declare the output register
  reg out_reg;
  
  // Define the state transition and output logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      // Asynchronous reset
      state <= A;
      out_reg <= 0;
    end else begin
      // Sequential logic
      state <= next_state;
      out_reg <= out;
    end
  end
  
  // Define the next state and output logic
  always @* begin
    case (state)
      A: begin
        if (in) begin
          next_state = B;
          out = 0;
        end else begin
          next_state = A;
          out = 0;
        end
      end
      B: begin
        if (in) begin
          next_state = B;
          out = 0;
        end else begin
          next_state = C;
          out = 0;
        end
      end
      C: begin
        if (in) begin
          next_state = D;
          out = 0;
        end else begin
          next_state = A;
          out = 0;
        end
      end
      D: begin
        if (in) begin
          next_state = B;
          out = 1;
        end else begin
          next_state = C;
          out = 1;
        end
      end
      default: begin
        next_state = A;
        out = 0;
      end
    endcase
  end

endmodule
