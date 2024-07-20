module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;
  reg [3:0] next_state;
  
  always @(posedge clk, posedge reset) begin
    if (reset)
      state <= 4'b0000;
    else
      state <= next_state;
  end
  
  always @(state, data) begin
    case (state)
      4'b0000: begin // Idle state
        if (data)
          next_state = 4'b0001;
        else
          next_state = 4'b0000;
      end
      
      4'b0001: begin // State 1
        if (data)
          next_state = 4'b0011;
        else
          next_state = 4'b0000;
      end
      
      4'b0011: begin // State 2
        if (data)
          next_state = 4'b0111;
        else
          next_state = 4'b0000;
      end
      
      4'b0111: begin // State 3
        if (data)
          next_state = 4'b1001;
        else
          next_state = 4'b0000;
      end
      
      4'b1001: begin // State 4
        if (data)
          next_state = 4'b1001;
        else
          next_state = 4'b0000;
      end
    endcase
  end
  
  always @(posedge clk, posedge reset) begin
    if (reset)
      start_shifting <= 1'b0;
    else if (state == 4'b1001)
      start_shifting <= 1'b1;
    else
      start_shifting <= 1'b0;
  end
  
endmodule
