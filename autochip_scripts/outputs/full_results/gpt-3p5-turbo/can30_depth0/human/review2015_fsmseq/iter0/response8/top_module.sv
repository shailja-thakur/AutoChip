module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 4'b0000;
    else begin
      case (state)
        4'b0000: if (data) state <= 4'b0001; else state <= 4'b0000;
        4'b0001: if (data) state <= 4'b0010; else state <= 4'b0000;
        4'b0010: if (data) state <= 4'b0011; else state <= 4'b0000;
        4'b0011: if (data) state <= 4'b0100; else state <= 4'b0000;
        4'b0100: if (data) state <= 4'b0010; else state <= 4'b0000;
      endcase
    end
  end

  always @(posedge clk or posedge reset) begin
    if (reset)
      start_shifting <= 1'b0;
    else if (state == 4'b0100)
      start_shifting <= 1'b1;
  end
endmodule
