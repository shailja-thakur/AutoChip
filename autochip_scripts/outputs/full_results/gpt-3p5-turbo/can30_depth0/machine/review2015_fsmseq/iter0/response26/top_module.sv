module top_module(
  input clk,
  input reset,
  input data,
  output start_shifting);

  reg [3:0] state;
  assign start_shifting = (state == 4'b1000);

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 4'b0000;
    else begin
      case (state)
        4'b0000: if (data) state <= 4'b0001; else state <= 4'b0000;
        4'b0001: if (data) state <= 4'b0011; else state <= 4'b0000;
        4'b0011: if (data) state <= 4'b0011; else state <= 4'b0110;
        4'b0110: if (data) state <= 4'b1000; else state <= 4'b0000;
        4'b1000: state <= 4'b1000;
      endcase
    end
  end

endmodule
