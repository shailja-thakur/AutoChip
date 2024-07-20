module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

  reg [1:0] state;
  reg [1:0] next_state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;
    end else begin
      state <= next_state;
    end
  end

  always @(state or j or k) begin
    case (state)
      2'b00: begin  // State A
        if (j) begin
          next_state <= 2'b01;  // Transition to State B
        end else begin
          next_state <= 2'b00;  // Remain in State A
        end
      end
      2'b01: begin  // State B
        if (k) begin
          next_state <= 2'b00;  // Transition to State A
        end else begin
          next_state <= 2'b01;  // Remain in State B
        end
      end
      default: begin
        next_state <= 2'b00;  // Default to State A
      end
    endcase
  end

  assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
