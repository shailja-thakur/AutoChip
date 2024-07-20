module top_module (
  input clk,
  input in,
  input reset,
  output reg [7:0] out_byte,
  output reg done
);
  reg [3:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      done <= 0;
      out_byte <= 8'b0;
    end else begin
      case(state)
        0: begin
          if(in == 1'b0) begin
            state <= 1;
          end
        end
        1: begin
          state <= 2;
        end
        2: begin
          for (i=0; i<8; i=i+1) begin
            state <= 3;
            out_byte[i] <= in;
          end
        end
        3: begin
          state <= 4;
        end
        4: begin
          if(in == 1'b1) begin
            state <= 5;
          end else if(in == 1'b0) begin
            state <= 2;
          end
        end
        5: begin
          done <= 1;
          state <= 0;
        end
      endcase
    end
  end
endmodule
