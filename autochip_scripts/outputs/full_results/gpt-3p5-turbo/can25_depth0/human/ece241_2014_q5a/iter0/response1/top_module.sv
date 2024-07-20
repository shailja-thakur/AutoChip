module top_module (
	input clk,
	input areset,
	input x,
	output z
);
  
  reg [1:0] state;
  reg [1:0] next_state;
  
  reg z_reg;
  reg z_next;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b0;
      z_reg <= 1'b0;
    end
    else begin
      state <= next_state;
      z_reg <= z_next;
    end
  end
  
  always @(state, x) begin
    case (state)
      2'b00: begin
        if (x)
          next_state = 2'b01;
        else
          next_state = 2'b00;
        
        z_next = z_reg;
      end
      2'b01: begin
        if (x)
          next_state = 2'b00;
        else
          next_state = 2'b11;
        
        z_next = ~z_reg + 1'b1;
      end
      2'b11: begin
        next_state = 2'b11;
        z_next = ~z_reg;
      end
    endcase
  end
  
  assign z = z_reg;
  
endmodule
