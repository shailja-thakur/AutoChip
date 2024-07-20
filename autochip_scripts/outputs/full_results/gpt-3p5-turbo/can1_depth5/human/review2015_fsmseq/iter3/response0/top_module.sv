module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting
);

  reg [3:0] state;
  reg [3:0] next_state;
  
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      state <= 0;
      start_shifting <= 0;
    end
    else begin
      state <= next_state;
      start_shifting <= (state == 4);
    end
  end
  
  always @(state or data) begin
    case(state)
      0: next_state = (data == 1) ? 1 : 0;
      1: next_state = (data == 1) ? 2 : 0;
      2: next_state = (data == 1) ? 3 : 0;
      3: next_state = (data == 1) ? 4 : 0;
      4: next_state = (data == 0) ? 0 : 4;
      default: next_state = 0;
    endcase
  end
  
endmodule
