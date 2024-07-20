module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);
  
  // Define the states
  parameter A = 0;
  parameter B = 1;
  parameter C = 2;
  parameter D = 3;
  parameter E = 4;
  parameter F = 5;

  // Define the current state and next state variables
  reg [2:0] state;
  reg [2:0] next_state;
  
  // Initialize the state machine
  always @(posedge clk) begin
    if (reset) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end
  
  // Determine the next state based on the current state and input w
  always @(state, w) begin
    case (state)
      A: begin
        if (w == 1'b0) begin
          next_state <= B;
        end else begin
          next_state <= A;
        end
      end
      B: begin
        if (w == 1'b1) begin
          next_state <= D;
        end else begin
          next_state <= C;
        end
      end
      C: begin
        if (w == 1'b1) begin
          next_state <= D;
        end else begin
          next_state <= E;
        end
      end
      D: begin
        if (w == 1'b1) begin
          next_state <= A;
        end else begin
          next_state <= F;
        end
      end
      E: begin
        if (w == 1'b1) begin
          next_state <= D;
        end else begin
          next_state <= E;
        end
      end
      F: begin
        if (w == 1'b1) begin
          next_state <= D;
        end else begin
          next_state <= C;
        end
      end
    endcase
  end
  
  // Output z based on the current state
  always @(state) begin
    case (state)
      A, B, C, D: begin
        z <= 1'b0;
      end
      E, F: begin
        z <= 1'b1;
      end
    endcase
  end

endmodule
