module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);

  reg [3:0] state;

  always @(posedge clk) begin
    if (shift_ena) begin
      state <= {state[2:0], data};
    end
    
    if (count_ena) begin
      if (state == 4'b0000) begin
        state <= 4'b1111;
      end else begin
        state <= state - 1;
      end
    end
  end

  assign q = state;

endmodule
