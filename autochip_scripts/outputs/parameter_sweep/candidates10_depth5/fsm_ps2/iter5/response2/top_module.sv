module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [1:0] state;
reg [1:0] next_state;
reg prev_in3;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 0;
    prev_in3 <= 0;
  end else begin
    state <= next_state;
    prev_in3 <= in[3];

    case (state)
      0: begin  // Idle state
        if (in[3] == 1 && prev_in3 == 0) begin
          next_state <= 1;  // Transition to first byte state
        end else begin
          next_state <= 0;
        end
      end
      1: begin  // First byte state
        next_state <= 2;  // Transition to second byte state
      end
      2: begin  // Second byte state
        next_state <= 3;  // Transition to third byte state
      end
      3: begin  // Third byte state
        next_state <= 0;  // Transition back to idle state
      end
    endcase
  end
end

assign done = (state == 3);

endmodule
