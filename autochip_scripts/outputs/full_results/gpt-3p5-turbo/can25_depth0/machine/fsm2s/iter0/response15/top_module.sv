module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output out
);

  reg [1:0] state;  // Register to store current state

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;  // Initialize state to A (00)
    end else begin
      case (state)
        2'b00: begin  // State A
          if (j) begin
            state <= 2'b01;  // Transition to state B (01) if j is high
          end
        end
        2'b01: begin  // State B
          if (k) begin
            state <= 2'b00;  // Transition to state A (00) if k is high
          end
        end
        default: state <= 2'b00;
      endcase
    end
  end

  assign out = (state == 2'b01) ? 1'b1 : 1'b0;  // Set output to 1 when state is B, 0 otherwise

endmodule
