module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

  reg [2:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 0;
    else begin
      case (state)
        0: if (data) state <= 1;
        1: if (data) state <= 2; else state <= 0;
        2: if (data) state <= 3; else state <= 0;
        3: if (data) start_shifting <= 1; state <= 4; else state <= 0;
        4: state <= 4;
      endcase
    end
  end

endmodule
