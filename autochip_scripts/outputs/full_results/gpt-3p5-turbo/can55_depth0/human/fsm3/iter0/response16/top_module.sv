module top_module (
  input clk,
  input in,
  input areset,
  output out
);
	
  reg [1:0] state;
  reg out_reg;
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b00;
    else begin
      case (state)
        2'b00: begin // State A
          if (in)
            state <= 2'b01;
          else
            state <= 2'b00;
          out_reg <= 1'b0;
        end
        2'b01: begin // State B
          if (in)
            state <= 2'b01;
          else
            state <= 2'b10;
          out_reg <= 1'b0;
        end
        2'b10: begin // State C
          if (in)
            state <= 2'b11;
          else
            state <= 2'b00;
          out_reg <= 1'b0;
        end
        2'b11: begin // State D
          if (in)
            state <= 2'b10;
          else
            state <= 2'b01;
          out_reg <= 1'b1;
        end
        default: state <= 2'b00;
      endcase 
    end
  end
  
  assign out = out_reg;
  
endmodule
