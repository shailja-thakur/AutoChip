module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 2'b00;
    out_bytes <= 0;
    done <= 0;
  end else begin
    case (state)
      2'b00: begin
        if (in[3]) begin
          state <= 2'b01;
        end else begin
          state <= 2'b00;
        end
      end
      2'b01: begin
        state <= 2'b10;
      end
      2'b10: begin
        state <= 2'b11;
        out_bytes <= {in, in[7:4]};
      end
      2'b11: begin
        state <= 2'b00;
        done <= 1;
      end
    endcase
  end
end

endmodule
