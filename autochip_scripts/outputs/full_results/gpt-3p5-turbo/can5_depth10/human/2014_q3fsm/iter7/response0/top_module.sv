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
parameter TWO_CYCLES = 2'b11;

reg [1:0] state;
reg [1:0] count;
reg [1:0] next_state;
reg [1:0] w_count;

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
          next_state <= A;
          count <= 0;
          if (w_count == TWO_CYCLES) begin
            z <= 1;
          end else begin
            z <= 0;
          end
        end else begin
          if (w == 1) begin
            w_count <= w_count + 1;
          end
          
          if (w_count == TWO_CYCLES) begin
            count <= count + 1;
          end
          
          z <= 0;
          next_state <= state;
        end
      end
    endcase
  end
end

endmodule
