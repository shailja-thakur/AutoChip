module top_module (
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
parameter TWO_CYCLES = 2'b11;

reg [1:0] state;
reg [1:0] count;
reg [1:0] next_state;
reg [1:0] w_prev;
reg [1:0] w_count;

always @(posedge clk) begin
  if (reset) begin
    state <= A;
    count <= 0;
    z <= 0;
    w_prev <= 0;
    w_count <= 0;
  end else begin
    state <= next_state;
    case (state)
      A: begin
        if (s) begin
          next_state <= B;
        end else begin
          next_state <= state;
        end
      end
      B: begin
        if (count == TWO_CYCLES) begin
          next_state <= A;
          z <= (w_count == 2);
          count <= 0;
          w_count <= 0;
        end else begin
          next_state <= state;
          count <= count + 1;
          if (w != w_prev) begin
            w_count <= w_count + 1;
          end else begin
            w_count <= w_count;
          end
        end
        w_prev <= w;
      end
    endcase
  end
end

endmodule
