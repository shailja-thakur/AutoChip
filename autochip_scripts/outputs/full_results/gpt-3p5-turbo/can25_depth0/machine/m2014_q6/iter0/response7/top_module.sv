module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

  reg [2:0] state;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
    end else begin
      case (state)
        3'b000: begin // State A
          if (w) begin
            state <= 3'b000;
          end else begin
            state <= 3'b001;
          end
        end
        3'b001: begin // State B
          if (w) begin
            state <= 3'b010;
          end else begin
            state <= 3'b011;
          end
        end
        3'b010: begin // State C
          if (w) begin
            state <= 3'b010;
          end else begin
            state <= 3'b100;
          end
        end
        3'b011: begin // State D
          if (w) begin
            state <= 3'b000;
          end else begin
            state <= 3'b101;
          end
        end
        3'b100: begin // State E
          if (w) begin
            state <= 3'b011;
          end else begin
            state <= 3'b100;
          end
        end
        3'b101: begin // State F
          if (w) begin
            state <= 3'b010;
          end else begin
            state <= 3'b110;
          end
        end
        default: begin
          state <= 3'b000;
        end
      endcase
    end
  end
  
  always @(state) begin
    if (state == 3'b100 || state == 3'b101) begin
      z <= 1'b1;
    end else begin
      z <= 1'b0;
    end
  end

endmodule
