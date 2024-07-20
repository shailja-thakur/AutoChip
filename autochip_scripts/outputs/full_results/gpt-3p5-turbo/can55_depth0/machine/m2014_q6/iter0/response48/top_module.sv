module top_module (
  input clk,
  input reset,
  input w,
  output z
);

  reg [2:0] state;    // State register
  wire clk_down;      // Clock down edge signal

  // Generate clock down edge signal
  assign clk_down = (~clk) & (clk - 1'b1);

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
    end else begin
      case(state)
        3'b000: if (w) state <= 3'b000; else state <= 3'b001;
        3'b001: if (w) state <= 3'b011; else state <= 3'b010;
        3'b010: if (w) state <= 3'b100; else state <= 3'b101;
        3'b011: state <= 3'b000;
        3'b100: state <= 3'b011;
        3'b101: state <= 3'b110;
        default: state <= 3'b000;
      endcase
    end
  end

  // Output z logic
  assign z = (state == 3'b101 || state == 3'b110) ? 1'b1 : 1'b0;

endmodule
