module top_module (
  input clk,
  input areset,
  input x,
  output reg z
);

  reg [1:0] state;
  reg [1:0] next_state;
  
  always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
      state <= 2'b00;
      z <= 1'b0;
    end 
    else begin
      state <= next_state;
      case (state)
        2'b00: begin
          next_state <= 2'b01;
          z <= x;
        end
        
        2'b01: begin
          next_state <= 2'b10;
          z <= ~x + 1;
        end
        
        2'b10: begin
          next_state <= 2'b00;
          z <= z;
        end
      endcase
    end
  end
  
endmodule
