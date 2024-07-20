module top_module (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 2'b00;
    z <= 0;
  end else begin
    case (state)
      2'b00: begin
        if (s == 0) begin
          state <= 2'b00;
          z <= 0;
        end else if (s == 1) begin
          state <= 2'b01;
          z <= 0;
        end
      end
      2'b01: begin
        if (w == 0) begin
          state <= 2'b00;
          z <= 0;
        end else if (w == 1) begin
          state <= 2'b10;
          z <= 0;
        end
      end
      2'b10: begin
        if (w == 0) begin
          state <= 2'b00;
          z <= 0;
        end else if (w == 1) begin
          state <= 2'b11;
          z <= 0;
        end
      end
      2'b11: begin
        if (w == 0) begin
          state <= 2'b00;
          z <= 0;
        end else if (w == 1) begin
          state <= 2'b00;
          z <= 1;
        end
      end
    endcase
  end
end

endmodule
