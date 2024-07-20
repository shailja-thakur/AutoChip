module top_module (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
  if (reset)
    state <= 2'b0;
  else begin
    case (state)
      2'b00: begin
        if (s)
          state <= 2'b01;
      end
      2'b01: begin
        if (w) begin
          state <= 2'b10;
        end
      end
      2'b10: begin
        if (w) begin
          state <= 2'b11;
          z <= 1;
        end else begin
          state <= 2'b01;
          z <= 0;
        end
      end
      2'b11: begin
        state <= 2'b10;
      end
      default: begin
        state <= 2'b0;
      end
    endcase
  end
end

endmodule
