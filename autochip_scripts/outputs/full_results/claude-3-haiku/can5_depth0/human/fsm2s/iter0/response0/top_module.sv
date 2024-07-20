module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

  // Define the states
  localparam OFF = 1'b0;
  localparam ON = 1'b1;

  // Define the state register
  reg state;

  always @(posedge clk) begin
    if (reset) begin
      state <= OFF;
      out <= 1'b0;
    end
    else begin
      case (state)
        OFF: begin
          if (j) begin
            state <= ON;
            out <= 1'b1;
          end
          else begin
            state <= OFF;
            out <= 1'b0;
          end
        end
        ON: begin
          if (k) begin
            state <= OFF;
            out <= 1'b0;
          end
          else begin
            state <= ON;
            out <= 1'b1;
          end
        end
        default: begin
          state <= OFF;
          out <= 1'b0;
        end
      endcase
    end
  end

endmodule
