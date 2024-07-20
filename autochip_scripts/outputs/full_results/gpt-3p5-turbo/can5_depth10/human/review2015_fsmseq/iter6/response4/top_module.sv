module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;
  reg [3:0] next_state;

  localparam S0 = 4'b00;
  localparam S1 = 4'b01;
  localparam S2 = 4'b10;
  localparam S3 = 4'b11;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= S0;
    else
      state <= next_state;
  end
  
  always @* begin
    next_state = state;
    case (state)
      S0: begin
        if (data)
          next_state = S1;
      end
      
      S1: begin
        if (data)
          next_state = S2;
        else
          next_state = S0;
      end
      
      S2: begin
        if (data)
          next_state = S3;
        else
          next_state = S0;
      end
      
      S3: begin
        if (data)
          next_state = S0;
        else
          next_state = S3;
      end
    endcase
  end

  always @(posedge clk)
    start_shifting <= (state == S3);

endmodule
