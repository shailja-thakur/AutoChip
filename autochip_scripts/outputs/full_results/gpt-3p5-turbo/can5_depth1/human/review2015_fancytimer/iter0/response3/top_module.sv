module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  reg [3:0] delay;
  reg [3:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
      counting <= 1'b0;
      done <= 1'b0;
      delay <= 4'b0;
      state <= 4'b0;
    end else begin
      case (state)
        4'b0000: begin
          if (data == 1'b1 && $past(data) == 1'b1) begin
            state <= 4'b0001;
          end else begin
            state <= 4'b0000;
          end
        end
        
        4'b0001: begin
          delay[3] <= data;
          state <= 4'b0010;
        end
        
        4'b0010: begin
          delay[2] <= data;
          state <= 4'b0011;
        end
        
        4'b0011: begin
          delay[1] <= data;
          state <= 4'b0100;
        end
        
        4'b0100: begin
          delay[0] <= data;
          state <= 4'b0101;
          counting <= 1'b1;
        end
        
        4'b0101: begin
          count <= delay;
          if (counting == 1'b1) begin
            if (count != 4'b0) begin
              counting <= 1'b1;
            end else begin
              counting <= 1'b0;
              done <= 1'b1;
              state <= 4'b0110;
            end
          end else begin
            counting <= 1'b0;
            done <= 1'b0;
            state <= 4'b0000;
          end
        end
        
        4'b0110: begin
          if (ack == 1'b1) begin
            counting <= 1'b0;
            done <= 1'b0;
            state <= 4'b0000;
          end else begin
            state <= 4'b0110;
          end
        end
      endcase
    end
  end
endmodule
