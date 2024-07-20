module top_module (
  input clk,
  input in,
  input reset,
  output out
);

reg out;
reg [1:0] state;
always @(posedge clk) begin
  if (reset) begin
    state <= 1'b1;
    out <= 1'b1;
  end else begin
    case (state)
      1'b0: begin // state B
        if (in)
          state <= 1'b0;
        else
          state <= 1'b1;
        out <= 1'b1;
      end
      1'b1: begin // state A
        if (in)
          state <= 1'b1;
        else
          state <= 1'b0;
        out <= 1'b0;
      end
      default: begin
        state <= 1'b1;
        out <= 1'b1;
      end
    endcase
  end
end

endmodule
