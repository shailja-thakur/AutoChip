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
reg [2:0] count;

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
        if (count == 3) begin
          if (count&2'b10 == 2'b10) begin
            z <= 1;
          end else begin
            z <= 0;
          end
          state <= A;
          count <= 0;
        end
      end
    endcase
  end
end

endmodule
