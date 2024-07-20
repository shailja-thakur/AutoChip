module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;
  reg [3:0] next_state;

  localparam S0 = 4'b0000;
  localparam S1 = 4'b0001;
  localparam S2 = 4'b0010;
  localparam S3 = 4'b0011;
  localparam S4 = 4'b0100;
  localparam S5 = 4'b0101; // Added state for detecting the sequence

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= S0;
    else
      state <= next_state;
  end
  
  always @* begin
    next_state = state;
    start_shifting = 0; // Reset start_shifting to 0 by default
    
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
          next_state = S4;
        else
          next_state = S0;
      end
      
      S4: begin
        if (data)
          next_state = S5;
        else
          next_state = S0;
      end
      
      S5: begin
        next_state = S0;
        start_shifting = 1; // Set start_shifting to 1 when the sequence is detected
      end
    endcase
  end

endmodule
