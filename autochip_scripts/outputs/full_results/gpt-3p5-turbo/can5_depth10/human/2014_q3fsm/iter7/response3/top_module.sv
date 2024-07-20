module top_module (
  input wire clk,
  input wire reset,
  input wire s,
  input wire w,
  output wire reg z
);

// Define states
parameter A = 2'b00;
parameter B = 2'b01;

reg [1:0] state;
reg [1:0] count;
reg [1:0] next_state;

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
          if (w == 2'b10) begin
            z <= 1;
          end else begin
            z <= 0;
          end
        end else begin
          if (w == 2'b10) begin
            count <= count + 1;
          end else begin
            count <= count;
          end
          z <= 0;
          next_state <= state;
        end
      end
    endcase
  end
end

endmodule
