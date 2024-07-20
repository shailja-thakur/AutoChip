module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output out
);

  // Define states
  parameter OFF = 0;
  parameter ON = 1;

  // Define state register
  reg [1:0] state;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= OFF;
    end else begin
      case (state)
        OFF: begin
          if (j) begin
            state <= ON;
          end else begin
            state <= OFF;
          end
        end
        ON: begin
          if (k) begin
            state <= OFF;
          end else begin
            state <= ON;
          end
        end
      endcase
    end
  end

  // Define output
  assign out = (state == ON) ? 1'b1 : 1'b0;

endmodule
