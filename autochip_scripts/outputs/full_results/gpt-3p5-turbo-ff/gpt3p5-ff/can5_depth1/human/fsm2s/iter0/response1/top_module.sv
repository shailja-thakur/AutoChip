module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output out
);

  reg [1:0] state;

  always @(posedge clk) begin
    if (reset) begin
      state <= 2'b00; // OFF state
    end else begin
      case (state)
        2'b00: begin // OFF state
          if (j) begin
            state <= 2'b01; // Transition to ON state
          end
        end
        2'b01: begin // ON state
          if (k) begin
            state <= 2'b00; // Transition to OFF state
          end
        end
      endcase
    end
  end

  assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
