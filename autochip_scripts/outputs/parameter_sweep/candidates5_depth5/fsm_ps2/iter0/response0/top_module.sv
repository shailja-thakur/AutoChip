module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
  
  reg [2:0] state;
  reg done_reg;
  reg [7:0] prev_byte;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      done_reg <= 0;
      prev_byte <= 0;
    end else begin
      case (state)
        0: begin
          if (in[3] == 1) begin
            state <= 1;
            prev_byte <= in;
          end
        end
        1: begin
          if (in[3] == 1) begin
            state <= 2;
            prev_byte <= in;
          end else begin
            state <= 0;
            prev_byte <= 0;
          end
        end
        2: begin
          if (in[3] == 1) begin
            state <= 1;
            prev_byte <= in;
          end else begin
            state <= 0;
            prev_byte <= 0;
            done_reg <= 1;
          end
        end
      endcase
    end
  end
  
  assign done = done_reg;
  
endmodule
