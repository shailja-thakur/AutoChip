module top_module(
  input clk,
  input reset,
  output reg shift_ena);

  reg [2:0] state;

  always @(posedge clk) begin
    if (reset) begin
      state <= 0;
      shift_ena <= 1;
    end else begin
      case (state)
        0: begin
          state <= 1;
          shift_ena <= 1;
        end
        1: begin
          state <= 2;
          shift_ena <= 1;
        end
        2: begin
          state <= 3;
          shift_ena <= 1;
        end
        3: begin
          state <= 3;
          shift_ena <= 0;
        end
        default: begin
          state <= 4;
          shift_ena <= 0;
        end
      endcase
    end
  end

endmodule
