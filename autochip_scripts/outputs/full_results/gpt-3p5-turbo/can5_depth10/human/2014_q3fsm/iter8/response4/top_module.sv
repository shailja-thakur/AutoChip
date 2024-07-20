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

always @(posedge clk) begin
  if (reset) begin
    state <= A;
    count <= 0;
    z <= 0;
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
          if (count(w_prev) == 2) begin
            z <= 1;
          end else begin
            z <= 0;
          end
          next_state <= A;
        end else begin
          if (w == 2'b01 || w == 2'b10) begin
            count <= count + 1;
          end else begin
            count <= count;
          end
          next_state <= state;
        end
      end
    endcase
  end
end

always @(posedge clk) begin
  w_prev <= w;
end

endmodule
