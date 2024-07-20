module top_module (
  input clk,
  input reset,
  input data,
  output reg start_shifting);
  
  reg [3:0] state;
  
  always @(posedge clk or posedge reset)begin
    if (reset)begin
      state <= 4'b0000;
      start_shifting <= 0;
    end
    else begin
      case(state)
        4'b0000:begin
          if (data) state <= 1;
          else state <= 4'b0000;
        end
        4'b0001:begin
          if (data) state <= 2;
          else state <= 4'b0000;
        end
        4'b0010:begin
          if (data) state <= 3;
          else state <= 4'b0000;
        end
        4'b0011:begin
          if (data) state <= 4'b0000;
          else state <= 4'b0000;
        end
        default: begin
          state <= 4'b0000;
        end
      endcase
    end
  end
  
  always @(posedge clk)begin
    if (state == 4'b0011)
      start_shifting <= 1;
    else if (reset)
      start_shifting <= 0;
  end
  
endmodule
