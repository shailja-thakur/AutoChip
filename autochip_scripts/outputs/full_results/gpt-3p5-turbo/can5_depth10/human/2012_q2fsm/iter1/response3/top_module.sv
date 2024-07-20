module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

  reg [2:0] state, next_state;

  // Define states
  parameter A = 3'b000;
  parameter B = 3'b001;
  parameter C = 3'b010;
  parameter D = 3'b011;
  parameter E = 3'b100;
  parameter F = 3'b101;

  // Define state transition table
  always @(posedge clk or negedge reset) begin
    if (reset) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end

  // Define next state logic
  always @(state, w) begin
    case (state)
      A: begin
        if (w) begin
          next_state = B;
        end else begin
          next_state = A;
        end
      end
      B: begin
        if (w) begin
          next_state = C;
        end else begin
          next_state = D;
        end
      end
      C: begin
        if (w) begin
          next_state = E;
        end else begin
          next_state = D;
        end
      end
      D: begin
        if (w) begin
          next_state = F;
        end else begin
          next_state = A;
        end
      end
      E: begin
        if (w) begin
          next_state = E;
        end else begin
          next_state = D;
        end
      end
      F: begin
        if (w) begin
          next_state = C;
        end else begin
          next_state = D;
        end
      end
      default: next_state = A;
    endcase
  end

  // Define output z
  always @(state) begin
    case (state)
       A, B, D: z = 0;
       default: z = 1;
    endcase
  end

endmodule
