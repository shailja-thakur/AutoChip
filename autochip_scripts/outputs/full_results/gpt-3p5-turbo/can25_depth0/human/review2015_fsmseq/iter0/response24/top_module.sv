module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  // internal signal
  reg [3:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 0;
    else begin
      case (state)
        4'b0000: if (data) state <= 4'b0001; else state <= 4'b0000;
        4'b0001: if (data) state <= 4'b0011; else state <= 4'b0000;
        4'b0011: if (data) state <= 4'b0111; else state <= 4'b0000;
        4'b0111: if (!data) state <= 4'b0000; else state <= 4'b1000;
        4'b1000: if (data) state <= 4'b1001; else state <= 4'b1000;
        4'b1001: if (data) state <= 4'b1011; else state <= 4'b1000;
        4'b1011: if (data) state <= 4'b1111; else state <= 4'b0000;
        4'b1111: if (!data) state <= 4'b0000; else start_shifting <= 1;
      endcase
    end
  end
  
endmodule
