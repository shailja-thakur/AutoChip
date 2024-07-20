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
parameter ZERO_CYCLES = 2'b00;
parameter ONE_CYCLE = 2'b01;
parameter TWO_CYCLES = 2'b10;

reg [1:0] state;
reg [1:0] count;
reg [1:0] next_state;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= A;
    count <= ZERO_CYCLES;
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
          next_state <= A;
          count <= ZERO_CYCLES;
          if (w == ONE_CYCLE) begin
            z <= 1;
          end else begin
            z <= 0;
          end
        end else begin
          count <= count + 1;
          z <= 0;
          next_state <= state;
        end
      end
    endcase
  end
end

endmodule
