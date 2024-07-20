module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;
  
  always @(posedge clk or posedge reset) begin
    if(reset)
      state <= 0;
    else begin
      case(state)
        0: if(data == 1)
             state <= 1;
           else
             state <= 0;
        1: if(data == 1)
             state <= 2;
           else
             state <= 0;
        2: if(data == 0)
             state <= 3;
           else
             state <= 0;
        3: if(data == 1) begin
             state <= 0;
             start_shifting <= 1;
           end else
             state <= 0;
        default: state <= 0;
      endcase
    end
  end
  
  assign start_shifting = 0;
  
endmodule
