module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

  // Define the states
  parameter OFF = 0;
  parameter ON = 1;

  // Define the state register
  reg [1:0] state_reg;
  reg [1:0] state_next;

  // Define the output register
  reg out_reg;

  // Synchronous reset
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state_reg <= OFF;
      out_reg <= 0;
    end else begin
      state_reg <= state_next;
      out_reg <= (state_reg == ON) ? 1'b1 : 1'b0;
    end
  end

  // Next state logic
  always @(*) begin
    case (state_reg)
      OFF: begin
        if (j) begin
          state_next = ON;
        end else begin
          state_next = OFF;
        end
      end
      ON: begin
        if (k) begin
          state_next = OFF;
        end else begin
          state_next = ON;
        end
      end
      default: state_next = state_reg;
    endcase
  end

  // Output assignment
  assign out = out_reg;

endmodule
