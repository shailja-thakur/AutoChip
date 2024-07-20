module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);
  
  // State encoding
  parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;
  
  // Internal signal for state register
  reg [2:0] state;
  
  // Next state logic
  always @(posedge clk) begin
    if (reset) begin
      state <= A; // Reset to state A
    end else begin
      case(state)
        A: begin
          if (w == 1'b0) begin
            state <= B;
          end else begin
            state <= A;
          end
        end
        B: begin
          if (w == 1'b1) begin
            state <= D;
          end else begin
            state <= C;
          end
        end
        C: begin
          if (w == 1'b1) begin
            state <= D;
          end else begin
            state <= E;
          end
        end
        D: begin
          if (w == 1'b1) begin
            state <= A;
          end else begin
            state <= F;
          end
        end
        E: begin
          if (w == 1'b1) begin
            state <= D;
          end else begin
            state <= E;
          end
        end
        F: begin
          if (w == 1'b1) begin
            state <= D;
          end else begin
            state <= C;
          end
        end
      endcase
    end
  end
  
  // Output logic
  always @(state, w) begin
    case(state)
      E, F: z = 1'b1;
      default: z = 1'b0;
    endcase
  end

endmodule
