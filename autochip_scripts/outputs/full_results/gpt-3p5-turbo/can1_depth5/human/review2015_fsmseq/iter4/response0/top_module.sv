module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting
);

  reg [3:0] state;
  reg [3:0] next_state;
  reg prev_data;
  
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      state <= 0;
      start_shifting <= 0;
    end
    else begin
      state <= next_state;
      start_shifting <= (state == 3);
    end
  end
  
  always @(state or data) begin
    case(state)
      0: begin
        if (data == 1)
          next_state = 1;
        else
          next_state = 0;
      end
      1: begin
        if (data == 1)
          next_state = 2;
        else
          next_state = 0;
      end
      2: begin
        if (data == 0)
          next_state = 3;
        else
          next_state = 0;
      end
      3: begin
        if (data == 1)
          next_state = 4;
        else
          next_state = 2;
      end
      4: begin
        if (data == 1)
          next_state = 2;
        else
          next_state = 0;
      end
    endcase
  end
  
endmodule
