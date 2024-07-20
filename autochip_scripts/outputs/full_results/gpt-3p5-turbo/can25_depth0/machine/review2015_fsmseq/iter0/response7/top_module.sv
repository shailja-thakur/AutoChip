module top_module (
  input clk,
  input reset,
  input data,
  output reg start_shifting
);

  reg [2:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000; // Initial state (S)
      start_shifting <= 1'b0;
    end else begin
      case (state)
        3'b000: if (data) state <= 3'b001; else state <= 3'b000;
        3'b001: if (data) state <= 3'b011; else state <= 3'b000;
        3'b011: if (data) state <= 3'b011; else state <= 3'b110;
        3'b110: if (data) state <= 3'b111; else state <= 3'b000;
        3'b111: state <= 3'b111;
      endcase
      
      if (state == 3'b111)
        start_shifting <= 1'b1;
      else
        start_shifting <= 1'b0;
    end
  end

endmodule
