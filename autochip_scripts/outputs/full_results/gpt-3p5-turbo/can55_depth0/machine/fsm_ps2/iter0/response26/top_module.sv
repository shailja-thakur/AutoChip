module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
  
  reg [1:0] state;
  reg done_reg;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;
      done_reg <= 0;
    end else begin
      case(state)
        2'b00:
          if (in[2] == 1) begin
            state <= 2'b01;
          end
        2'b01:
          state <= 2'b10;
        2'b10:
          state <= 2'b11;
        2'b11:
          if (in[2] == 0) begin
            state <= 2'b00;
          end else begin
            state <= 2'b01;
          end
      endcase
      
      if (state == 2'b11) begin
        done_reg <= 1;
      end else begin
        done_reg <= 0;
      end
    end
  end
  
  assign done = done_reg;
endmodule
