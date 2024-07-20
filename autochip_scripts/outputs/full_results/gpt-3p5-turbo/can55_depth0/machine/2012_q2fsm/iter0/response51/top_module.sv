module top_module (
  input clk,
  input reset,
  input w,
  output z
);

  reg [2:0] state;
  wire z;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'd0; // Initial state is A
    end else begin
      case (state)
        3'd0: begin // State A
          if (w) state <= 3'd1; // Transition to state B if w = 1
        end
        3'd1: begin // State B
          if (w) state <= 3'd2; // Transition to state C if w = 1
          else state <= 3'd3; // Transition to state D if w = 0
        end
        3'd2: begin // State C
          if (w) state <= 3'd4; // Transition to state E if w = 1
          else state <= 3'd3; // Transition to state D if w = 0
        end
        3'd3: begin // State D
          if (w) state <= 3'd5; // Transition to state F if w = 1
          else state <= 3'd0; // Transition to state A if w = 0
        end
        3'd4: begin // State E
          if (w) state <= 3'd4; // Continue in state E if w = 1
          else state <= 3'd3; // Transition to state D if w = 0
        end
        3'd5: begin // State F
          if (w) state <= 3'd2; // Transition to state C if w = 1
          else state <= 3'd3; // Transition to state D if w = 0
        end
      endcase
    end
  end

  assign z = (state == 3'd4 || state == 3'd5) ? 1'b1 : 1'b0;

endmodule
