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
reg prev_w1, prev_w2, prev_w3;

always @(posedge clk) begin
  if (reset) begin
    state <= A;
    count <= 0;
    z <= 0;
    prev_w1 <= 0;
    prev_w2 <= 0;
    prev_w3 <= 0;
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
          count <= 0;
          if (prev_w1 && prev_w2) begin
            z <= 1;
          end else begin
            z <= 0;
          end
          next_state <= A;
        end else begin
          prev_w3 <= prev_w2;
          prev_w2 <= prev_w1;
          prev_w1 <= w;
          
          if (count == TWO_CYCLES-1) begin
            prev_w1 <= 0;
          end
          
          count <= count + 1;
          next_state <= state;
        end
      end
    endcase
  end
end

endmodule
