module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
  
  reg [1:0] state, next_state;
  reg [2:0] count;
  
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
  
  always @(posedge clk) begin
    if (state == S2 && next_state == S0) begin
      count <= count + 1;
      if (count >= 2) // check if "101" sequence has been detected
        z <= 1'b1;
    end
    else begin
      count <= 0;
      z <= 1'b0;
    end
  end
  
endmodule
