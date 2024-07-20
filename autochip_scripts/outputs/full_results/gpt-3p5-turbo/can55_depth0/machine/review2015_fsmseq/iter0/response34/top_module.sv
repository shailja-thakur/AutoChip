module top_module(
  input clk,
  input reset,
  input data,
  output start_shifting);

  reg [2:0] state;
  reg start_shifting;

  always @(posedge clk) begin
    if (reset)
      state <= 3'b000;
    else begin
      case (state)
        3'b000: if (data) state <= 3'b001; else state <= 3'b000;
        3'b001: if (data) state <= 3'b011; else state <= 3'b000;
        3'b011: if (data) state <= 3'b011; else state <= 3'b110;
        3'b110: if (data) state <= 3'b111; else state <= 3'b000;
        default: state <= state;
      endcase
    end
  end

  always @(state)
    start_shifting = (state == 3'b111) ? 1'b1 : 1'b0;

endmodule
