module top_module(
  input clk,
  input reset,
  input data,
  output start_shifting
);
  
  reg [3:0] state;
  wire [3:0] next_state;
    
  always @(posedge clk or posedge reset) begin
    if(reset)
      state <= 4'b0000;
    else
      state <= next_state;
  end
  
  assign next_state = (state == 4'b0000 && data) ? 4'b0001 : 
                     (state == 4'b0001 && data) ? 4'b0011 :
                     (state == 4'b0011 && data) ? 4'b0011 :
                     (state == 4'b0011 && !data) ? 4'b0110 :
                     (state == 4'b0110 && data) ? 4'b1111 :
                     state;
  
  assign start_shifting = (state == 4'b1111) ? 1'b1 : 1'b0;
  
endmodule
