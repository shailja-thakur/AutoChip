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
    state <= 3'b000;
  end else begin
    case(state)
      3'b000: begin // State A
        if (w == 1'b0) begin
          state <= 3'b000;
        end else begin
          state <= 3'b001;
        end
      end
      3'b001: begin // State B
        if (w == 1'b0) begin
          state <= 3'b010;
        end else begin
          state <= 3'b011;
        end
      end
      3'b010: begin // State C
        if (w == 1'b0) begin
          state <= 3'b010;
        end else begin
          state <= 3'b100;
        end
      end
      3'b011: begin // State D
        if (w == 1'b0) begin
          state <= 3'b000;
        end else begin
          state <= 3'b110;
        end
      end
      3'b100: begin // State E
        if (w == 1'b0) begin
          state <= 3'b011;
        end else begin
          state <= 3'b100;
        end
      end
      3'b110: begin // State F
        if (w == 1'b0) begin
          state <= 3'b011;
        end else begin
          state <= 3'b110;
        end
      end
      default: state <= 3'b000;
    endcase
  end
end

assign z = (state == 3'b100) || (state == 3'b110);

endmodule
