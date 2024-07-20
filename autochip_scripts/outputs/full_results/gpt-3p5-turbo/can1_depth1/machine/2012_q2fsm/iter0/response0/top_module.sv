module top_module (
  input clk,
  input reset,
  input w,
  output z
);

  reg [2:0] state;
  assign z = (state == 3'b100) || (state == 3'b101);

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
    end else begin
      case (state)
        3'b000:
          if (w) begin
            state <= 3'b001;
          end else begin
            state <= 3'b000;
          end
        3'b001:
          if (w) begin
            state <= 3'b010;
          end else begin
            state <= 3'b100;
          end
        3'b010:
          if (w) begin
            state <= 3'b110;
          end else begin
            state <= 3'b011;
          end
        3'b011:
          if (w) begin
            state <= 3'b100;
          end else begin
            state <= 3'b000;
          end
        3'b100:
          if (w) begin
            state <= 3'b100;
          end else begin
            state <= 3'b100;
          end
        3'b101:
          if (w) begin
            state <= 3'b011;
          end else begin
            state <= 3'b010;
          end
      endcase
    end
  end

endmodule
