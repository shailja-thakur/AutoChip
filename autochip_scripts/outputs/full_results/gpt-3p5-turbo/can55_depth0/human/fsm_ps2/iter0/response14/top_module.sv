module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [2:0] state;
reg [7:0] shift_reg;

always @(posedge clk) begin
  if (reset) begin
    state <= 0;
    shift_reg <= 0;
    done <= 0;
  end else begin
    case (state)
      0: begin
        if (in[3] == 1) begin
          shift_reg <= in;
          state <= 1;
        end
      end
      1: begin
        shift_reg <= {shift_reg[6:0], in};
        state <= 2;
      end
      2: begin
        shift_reg <= {shift_reg[6:0], in};
        state <= 0;
        done <= 1;
      end
      default: state <= 0;
    endcase
  end
end

endmodule
