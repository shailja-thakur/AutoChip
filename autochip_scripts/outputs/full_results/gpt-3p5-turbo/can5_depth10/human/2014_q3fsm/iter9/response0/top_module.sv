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
reg prev_w; // added reg to store previous value of w

always @(posedge clk) begin
  if (reset) begin
    state <= A;
    count <= 0;
    z <= 0;
    prev_w <= 0; // initialize prev_w
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
          if (count == TWO_CYCLES-1) begin
            z <= 1;
          end else begin
            z <= 0;
          end
          next_state <= A;
        end else begin
          if (prev_w == 1 && w == 1) begin // check previous and current values of w
            count <= count + 1;
          end else begin
            count <= count;
          end
          next_state <= state;
        end
      end
    endcase
    prev_w <= w; // update prev_w with current value of w
  end
end

endmodule
