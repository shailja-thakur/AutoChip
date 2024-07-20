module top_module(
	input clk,
	input reset,
	output shift_ena);

  reg [3:0] state;
  parameter [2:0] S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= S0;
      shift_ena <= 1'b1;
    end else begin
      case (state)
        S0: begin
          if (bit_pattern_detected) begin
            state <= S1;
            shift_ena <= 1'b1;
          end else begin
            state <= S0;
            shift_ena <= 1'b0;
          end
        end

        S1: begin
          state <= S2;
          shift_ena <= 1'b1;
        end

        S2: begin
          state <= S3;
          shift_ena <= 1'b1;
        end

        S3: begin
          state <= S0;
          shift_ena <= 1'b0;
        end
      endcase
    end
  end

  // Rest of the module implementation...

endmodule
