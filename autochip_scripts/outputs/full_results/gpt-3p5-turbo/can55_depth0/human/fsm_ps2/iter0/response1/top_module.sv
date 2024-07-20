module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [1:0] state;
reg done;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 2'b00;
    done <= 0;
  end
  else begin
    case (state)
      2'b00:
        if (in[3]) begin
          state <= 2'b01;
        end
        else begin
          state <= 2'b00;
        end
      2'b01:
        state <= 2'b10;
      2'b10:
        if (in[3]) begin
          state <= 2'b11;
        end
        else begin
          state <= 2'b00;
        end
      2'b11:
        state <= 2'b00;
    endcase
    if (state == 2'b11) begin
      done <= 1;
    end
    else begin
      done <= 0;
    end
  end
end

endmodule
