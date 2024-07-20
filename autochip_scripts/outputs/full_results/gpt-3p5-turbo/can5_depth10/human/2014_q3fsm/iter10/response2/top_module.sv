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
  wire w_count;

  assign w_count = (count == TWO_CYCLES-1);

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
          count <= 0; // Reset count in state A
        end
        B: begin
          if (count == TWO_CYCLES) begin
            if (w_count) begin
              z <= 1;
            end else begin
              z <= 0;
            end
            next_state <= A;
          end else begin
            if (w) begin
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

endmodule
