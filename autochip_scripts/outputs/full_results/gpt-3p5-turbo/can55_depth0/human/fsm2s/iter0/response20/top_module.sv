module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output reg out
);

  reg [1:0] state;

  always @(posedge clk, negedge reset) begin
    if (reset) begin
      state <= 2'b0;
      out <= 1'b0;
    end else begin
      case (state)
        2'b00: begin  // OFF state
          if (j) begin
            state <= 2'b01;  // transition to ON state
            out <= 1'b0;
          end else begin
            state <= 2'b00;  // stay in OFF state
          end
        end
        2'b01: begin  // ON state
          if (k) begin
            state <= 2'b00;  // transition to OFF state
            out <= 1'b1;
          end else begin
            state <= 2'b01;  // stay in ON state
          end
        end
        default: state <= 2'b0;
      endcase
    end
  end

endmodule
