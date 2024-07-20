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

// Define count values
parameter TWO_CYCLES = 2'b10;

reg [1:0] state;
reg [1:0] count;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= A;
    count <= 0;
    z <= 0;
  end else begin
    case (state)
      A: begin
        if (s) begin
          state <= B;
        end
      end
      B: begin
        if (w) begin
          count <= count + 1;
        end
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
