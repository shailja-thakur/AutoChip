module top_module(
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

// Define states
parameter A = 2'b00;
parameter B = 2'b01;

reg [1:0] state;
reg [1:0] count;
reg prev_w;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= A;
    count <= 0;
    z <= 0;
    prev_w <= 0;
  end else begin
    case (state)
      A: begin
        if (s) begin
          state <= B;
        end
      end
      B: begin
        if (w != prev_w) begin
          count <= count + 1;
        end
        prev_w <= w;
        if (count == TWO_CYCLES) begin
          z <= 1;
        end else begin
          z <= 0;
        end
        state <= A;
        count <= 0;
      end
    endcase
  end
end

endmodule
