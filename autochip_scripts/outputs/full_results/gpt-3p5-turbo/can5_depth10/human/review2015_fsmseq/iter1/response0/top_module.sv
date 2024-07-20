module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  // State declaration
  reg [3:0] state;

  // State encoding
  localparam S0 = 4'b0000;
  localparam S1 = 4'b0001;
  localparam S2 = 4'b0010;
  localparam S3 = 4'b0011;
  localparam S4 = 4'b0100; // Sequence found state

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= S0;
    else begin
      case (state)
        S0: begin
          if (data)
            state <= S1;
        end
        
        S1: begin
          if (data)
            state <= S2;
          else
            state <= S0;
        end
        
        S2: begin
          if (data)
            state <= S3;
          else
            state <= S0;
        end
        
        S3: begin
          if (data)
            state <= S4;
          else
            state <= S0;
        end
        
        S4: begin
          if (reset)
            state <= S0;
          else
            state <= S4;
        end
      endcase
    end
  end

  // Output assignment
  always @(posedge clk) begin
    if (reset)
      start_shifting <= 0;
    else if (state == S4)
      start_shifting <= 1;
  end

endmodule
