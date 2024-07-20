module top_module(
  input clk,
  input reset,
  input data,
  output start_shifting);
  
  reg [3:0] state;
  wire should_shift;
  
  assign start_shifting = (state == 4'b1100) ? 1'b1 : 1'b0;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 4'b0000;
    end else begin
      case (state)
        4'b0000: begin
          state <= (data) ? 4'b0001 : 4'b0000;
        end
        4'b0001: begin
          state <= (data) ? 4'b0011 : 4'b0000;
        end
        4'b0011: begin
          state <= (data) ? 4'b0011 : 4'b0110;
        end
        4'b0110: begin
          state <= (data) ? 4'b1100 : 4'b0000;
        end
        default: begin
          state <= 4'b1100;
        end
      endcase
    end
  end
  
endmodule
