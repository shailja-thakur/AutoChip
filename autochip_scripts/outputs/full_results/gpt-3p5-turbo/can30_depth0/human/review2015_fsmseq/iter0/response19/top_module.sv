module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting
);

  reg [3:0] state;
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 4'd0;
    else begin
      case (state)
        4'd0: if (data) state <= 4'd1; else state <= 4'd0;
        4'd1: if (data) state <= 4'd2; else state <= 4'd0;
        4'd2: if (data) state <= 4'd3; else state <= 4'd0;
        4'd3: if (data) state <= 4'd4; else state <= 4'd0;
        4'd4: state <= 4'd0;
      endcase
    end
  end
  
  always @(posedge clk)
    if (reset)
      start_shifting <= 1'b0;
    else if (state == 4'd4)
      start_shifting <= 1'b1;

endmodule
