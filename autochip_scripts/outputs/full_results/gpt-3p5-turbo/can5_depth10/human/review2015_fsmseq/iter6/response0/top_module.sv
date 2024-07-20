module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;
  reg [3:0] next_state;
  
  reg [3:0] counter;
  wire match;
  
  localparam S0 = 4'b0000;
  localparam S1 = 4'b0001;
  localparam S2 = 4'b0010;
  localparam S3 = 4'b0011;
  localparam S4 = 4'b0100;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= S0;
    else
      state <= next_state;
  end
  
  always @* begin
    next_state = state;
    counter <= counter + 1;
    match <= (counter[3] & ~data) | (~counter[3] & data);

    case (state)
      S0: begin
        if (match)
          next_state = S1;
      end
      
      S1: begin
        if (match)
          next_state = S2;
        else
          next_state = S0;
      end
      
      S2: begin
        if (match)
          next_state = S3;
        else
          next_state = S0;
      end
      
      S3: begin
        if (match)
          next_state = S4;
        else
          next_state = S0;
      end
      
      S4: begin
        if (reset)
          next_state = S0;
        else
          next_state = S4;
      end
    endcase
  end

  always @(posedge clk)
    start_shifting <= (state == S4);

endmodule
