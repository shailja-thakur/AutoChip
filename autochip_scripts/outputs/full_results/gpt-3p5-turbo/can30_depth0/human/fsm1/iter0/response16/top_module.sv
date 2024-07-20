module top_module (
  input clk,
  input in,
  input areset,
  output out
);
  
  reg [1:0] state, next_state;
  
  parameter B = 2'b00;
  parameter A = 2'b01;

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= B;
    else
      state <= next_state;
  end

  always @(*) begin
    case(state)
      
      B: begin
        if (in)
          next_state = B;
        else
          next_state = A;
      end

      A: begin
        if (in)
          next_state = A;
        else
          next_state = B;
      end
      
    endcase
  end

  always @(posedge clk) begin
    case(state)
      
      B: out <= 0;
      A: out <= 1;
      
    endcase
  end

endmodule
