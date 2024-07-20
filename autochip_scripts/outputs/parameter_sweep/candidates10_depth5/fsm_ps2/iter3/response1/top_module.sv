module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [2:0] state;
reg [7:0] prev_in;
reg [7:0] in_shift;
reg [7:0] in_prev_shift;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 0;
  end else begin
    prev_in <= in;
    in_shift <= {in_shift[6:0], in[7]};
    in_prev_shift <= {in_prev_shift[6:0], prev_in[7]};

    case (state)
      0: begin  // Idle state
        if (prev_in[3] == 1 && in_prev_shift[3] == 0) begin
          state <= 1;  // Transition to first byte state
        end else begin
          state <= 0;
        end
      end
      1: begin  // First byte state
        if (in_shift[3] == 1 && in_prev_shift[3] == 0) begin
          state <= 2;  // Transition to second byte state
        end
      end
      2: begin  // Second byte state
        if (in_shift[3] == 1 && in_prev_shift[3] == 0) begin
          state <= 3;  // Transition to third byte state
        end
      end
      3: begin  // Third byte state
        state <= 0;  // Transition back to idle state
      end
    endcase
  end
end

assign done = (state == 3);

endmodule
