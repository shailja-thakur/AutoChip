module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
  
  reg [1:0] state, next_state;
  
  parameter S0 = 2'b00;
  parameter S1 = 2'b01;
  parameter S2 = 2'b10;
  
  always @(posedge clk or negedge aresetn) begin
    if (~aresetn)
      state <= S0;
    else
      state <= next_state;
  end
  
  always @(state or x) begin
    case (state)
      S0: begin
        if (x)
          next_state = S1;
        else
          next_state = S0;
      end
      
      S1: begin
        if (x)
          next_state = S2;
        else
          next_state = S0;
      end
      
      S2: begin
        if (x)
          next_state = S1;
        else
          next_state = S0;
      end
      
      default: next_state = S0;
    endcase
  end
  
  always @(posedge clk or negedge aresetn) begin
    if (~aresetn)
      z <= 1'b0;
    else begin
      if (state == S2 && next_state == S0)
        z <= 1'b1;
      else
        z <= 1'b0;
    end
  end
  
endmodule
