module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [2:0] state;
reg prev_in3;
reg [2:0] byte_count;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 0;
    prev_in3 <= 0;
    byte_count <= 0;
  end else begin
    prev_in3 <= in[3];

    case (state)
      0: begin  // Idle state
        if (in[3] == 1 && prev_in3 == 0) begin
          state <= 1;  // Transition to first byte state
        end else begin
          state <= 0;
        end
      end
      1: begin  // First byte state
        state <= 2;  // Transition to second byte state
        byte_count <= 1;
      end
      2: begin  // Second byte state
        state <= 3;  // Transition to third byte state
        byte_count <= 2;
      end
      3: begin  // Third byte state
        state <= 0;  // Transition back to idle state
        byte_count <= 0;
      end
    endcase
  end
end

assign done = (state == 3 && byte_count == 2);

endmodule
