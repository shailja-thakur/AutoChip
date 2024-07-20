module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

  reg [3:0] state;
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 4'b0000;
    else begin
      case (state)
        4'b0000: begin // State A
          if (w)
            state <= 4'b0000;
          else
            state <= 4'b0001;
        end
        4'b0001: begin // State B
          if (w)
            state <= 4'b0100;
          else
            state <= 4'b0010;
        end
        4'b0010: begin // State C
          if (w)
            state <= 4'b0100;
          else
            state <= 4'b0011;
        end
        4'b0011: begin // State D
          if (w)
            state <= 4'b0000;
          else
            state <= 4'b0110;
        end
        4'b0100: begin // State E
          if (w)
            state <= 4'b0011;
          else
            state <= 4'b0100;
        end
        4'b0110: begin // State F
          if (w)
            state <= 4'b0011;
          else
            state <= 4'b0010;
        end
        default: state <= 4'b0000;
      endcase
    end
  end

  always @(state) begin
    if (state == 4'b0100 || state == 4'b0110)
      z <= 1'b1;
    else
      z <= 1'b0;
  end

endmodule
