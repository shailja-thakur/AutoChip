module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

  reg [1:0] state;
  parameter S0 = 2'b00;
  parameter S1 = 2'b01;
  parameter S2 = 2'b10;
  
  // FSM logic
  always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
      state <= S0; // Reset to initial state
      z <= 0; // Reset the output
    end else begin
      case (state)
        S0: begin
          if (x == 1'b1)
            state <= S1;
          else
            state <= S0;
        end
        S1: begin
          if (x == 1'b0)
            state <= S2;
          else
            state <= S0;
        end
        S2: begin
          if (x == 1'b1) begin
            state <= S1;
            z <= 1; // Output is asserted to logic-1 when "101" sequence is detected
          end else
            state <= S0;
        end
        default: state <= S0; // Default case for any unknown state
      endcase
    end
  end

endmodule
