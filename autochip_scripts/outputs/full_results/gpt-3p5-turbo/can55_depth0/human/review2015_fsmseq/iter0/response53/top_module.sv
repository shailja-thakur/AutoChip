module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);
  
  reg [1:0] state;
  reg [3:0] count;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b00;
    else begin
      case (state)
        2'b00: begin
          if (data)
            state <= 2'b01;
        end
        2'b01: begin
          if (data)
            state <= 2'b10;
          else
            state <= 2'b00;
        end
        2'b10: begin
          if (data)
            state <= 2'b11;
          else
            state <= 2'b00;
        end
        2'b11: begin
          if (data)
            begin
              start_shifting <= 1;
              state <= 2'b11;
            end
          else
            state <= 2'b00;
        end
        default: state <= 2'b00;
      endcase
    end
  end
  
endmodule
