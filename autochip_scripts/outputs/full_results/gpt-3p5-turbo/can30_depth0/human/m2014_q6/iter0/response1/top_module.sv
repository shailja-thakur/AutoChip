module top_module (
  input clk,
  input reset,
  input w,
  output z
);

// Define state machine states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
parameter E = 2'b100;
parameter F = 2'b101;

// Define state register
reg [2:0] state;
// Define next state register
reg [2:0] next_state;

// Define output register
reg z;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    // Reset state to A
    state <= A;
  end else begin
    // Update state based on current state and input w
    case (state)
      A: begin
        if (w) begin
          next_state <= A;
        end else begin
          next_state <= B;
        end
      end
      B: begin
        if (w) begin
          next_state <= D;
        end else begin
          next_state <= C;
        end
      end
      C: begin
        if (w) begin
          next_state <= D;
        end else begin
          next_state <= E;
        end
      end
      D: begin
        if (w) begin
          next_state <= A;
        end else begin
          next_state <= F;
        end
      end
      E: begin
        if (w) begin
          next_state <= D;
        end else begin
          next_state <= E;
        end
      end
      F: begin
        if (w) begin
          next_state <= D;
        end else begin
          next_state <= C;
        end
      end
    endcase
  end
end

always @(posedge clk) begin
  // Update state with next_state
  state <= next_state;
end

// Output logic
always @(state) begin
  case (state)
    A, B: begin
      // Output z is 0
      z <= 0;
    end
    C, D, E: begin
      // Output z is 1
      z <= 1;
    end
    F: begin
      // Output z is 0 if w is 0, else 1
      z <= w;
    end
  endcase
end

endmodule
