module top_module (
  input clk,
  input reset,
  input data,
  output reg start_shifting
);
  
  reg [3:0] state;
  
  always @(posedge clk) begin
    if (reset) begin
      start_shifting <= 0;
      state <= 0;
    end else begin
      case (state)
        0: begin
          if (data) state <= 1;
        end
        1: begin
          if (data) state <= 2;
          else state <= 0;
        end
        2: begin
          if (data) state <= 3;
          else state <= 0;
        end
        3: begin
          if (data) begin
            start_shifting <= 1;
            state <= 4;
          end else begin
            state <= 0;
          end
        end
        4: begin
          if (reset) begin
            start_shifting <= 0;
            state <= 0;
          end
        end
      endcase
    end
  end
endmodule
