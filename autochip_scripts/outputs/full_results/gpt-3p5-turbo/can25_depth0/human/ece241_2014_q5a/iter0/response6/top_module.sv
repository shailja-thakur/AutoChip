module top_module (
  input clk,
  input areset,
  input x,
  output z
);

  // Define states
  parameter IDLE = 2'b00;
  parameter CONVERTING = 2'b01;
  
  reg [1:0] state;
  reg [1:0] next_state;
  
  // Output register
  reg z_reg;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= IDLE;
      z_reg <= 1'b0;
    end
    else begin
      state <= next_state;
      z_reg <= x ? ~z_reg : z_reg;
    end
  end
  
  always @(state) begin
    case (state)
      IDLE:
        if (~areset)
          next_state = CONVERTING;
        else
          next_state = IDLE;
      
      CONVERTING:
        if (~x & areset)
          next_state = IDLE;
        else
          next_state = CONVERTING;
    endcase
  end
  
  assign z = z_reg;
  
endmodule
