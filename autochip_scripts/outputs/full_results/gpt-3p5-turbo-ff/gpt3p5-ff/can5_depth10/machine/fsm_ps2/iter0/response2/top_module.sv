module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [1:0] state;
assign done = (state == 2'd3);

always @(posedge clk or posedge reset) begin
  if (reset)
    state <= 2'd0;
  else begin
    case (state)
      2'd0: begin
        if (in[2])
          state <= 2'd1;
        else
          state <= 2'd0;
      end
      2'd1: begin
        state <= 2'd2;
      end
      2'd2: begin
        state <= 2'd3;
      end
      2'd3: begin
        if (in[2])
          state <= 2'd1;
        else
          state <= 2'd0;
      end
    endcase
  end
end

endmodule
