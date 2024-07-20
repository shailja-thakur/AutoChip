module top_module (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

reg [1:0] state;

always @(posedge clk) begin
  if (reset) begin
    state <= 2'b00; // Reset state A
    z <= 0;
  end else begin
    case (state)
      2'b00: begin  // State A
        if (s == 0) begin
          state <= 2'b00;  // Stay in state A
        end else begin
          state <= 2'b01;  // Move to state B
        end
      end
      2'b01: begin  // State B
        state <= 2'b10;  // Move to state C
      end
      2'b10: begin  // State C
        if (w == 1) begin
          state <= 2'b11;  // Move to state D
        end else begin
          state <= 2'b01;  // Move back to state B
        end
      end
      2'b11: begin  // State D
        if (w == 1) begin
          state <= 2'b11;  // Stay in state D
        end else begin
          state <= 2'b01;  // Move back to state B
        end
      end
    endcase
  end
end

always @(posedge clk) begin
  if (reset) begin
    z <= 0;
  end else begin
    if (state == 2'b11) begin
      if ((w == 1) && (z == 0))
        z <= 1;  // Set output z to 1
      else
        z <= 0;  // Set output z to 0
    end
  end
end

endmodule
