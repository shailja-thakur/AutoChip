module top_module (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err);
  
  reg [2:0] state;  // State register
  reg disc_reg;    // Register for disc output
  reg flag_reg;    // Register for flag output
  reg err_reg;     // Register for err output
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;  // Reset state to initial state
      disc_reg <= 1'b0; // Reset disc_reg to 0
      flag_reg <= 1'b0; // Reset flag_reg to 0
      err_reg <= 1'b0;  // Reset err_reg to 0
    end
    else begin
      case (state)
        3'b000:
          if (in) begin
            state <= 3'b001;  // Move to state 1
          end
          else begin
            state <= 3'b000;  // Stay in state 0
          end
        3'b001:
          if (in) begin
            state <= 3'b010;  // Move to state 2
          end
          else begin
            state <= 3'b000;  // Reset to state 0
          end
        3'b010:
          if (in) begin
            state <= 3'b011;  // Move to state 3
          end
          else begin
            state <= 3'b000;  // Reset to state 0
          end
        3'b011:
          if (in) begin
            state <= 3'b011;  // Stay in state 3
          end
          else begin
            state <= 3'b100;  // Move to state 4
          end
        3'b100:
          if (in) begin
            state <= 3'b101;  // Move to state 5
          end
          else begin
            state <= 3'b101;  // Move to state 5
          end
        3'b101:
          if (in) begin
            state <= 3'b110;  // Move to state 6
          end
          else begin
            state <= 3'b000;  // Reset to state 0
          end
        3'b110:
          if (in) begin
            disc_reg <= 1'b1; // Set disc_reg to 1
            flag_reg <= 1'b0; // Reset flag_reg to 0
            err_reg <= 1'b0;  // Reset err_reg to 0
            state <= 3'b000;  // Reset to state 0
          end
          else begin
            state <= 3'b110;  // Stay in state 6
          end
      endcase
    end
  end
  
  assign disc = disc_reg;  // Output disc signal
  assign flag = flag_reg;  // Output flag signal
  assign err = err_reg;    // Output err signal

endmodule
