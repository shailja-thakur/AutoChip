module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

  reg [1:0] state;
  wire third_bit = in[2];

  assign done = (state == 2'b11);
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b00;
    else begin
      case (state)
        2'b00: begin // BYTE1 state
          if (third_bit)
            state <= 2'b01; // Transition to BYTE2 state
          else
            state <= 2'b00; // Remain in BYTE1 state
        end
        2'b01: begin // BYTE2 state
          state <= 2'b10; // Transition to BYTE3 state
        end
        2'b10: begin // BYTE3 state
          state <= 2'b11; // Transition to DONE state
        end
        2'b11: begin // DONE state
          if (third_bit)
            state <= 2'b01; // Transition to BYTE2 state
          else
            state <= 2'b00; // Transition to BYTE1 state
        end
        default: state <= 2'b00; // Default state is BYTE1 state
      endcase
    end
  end
endmodule
