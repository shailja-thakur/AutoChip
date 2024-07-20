module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);
  
  reg [23:0] out_reg;     // 24-bit register to store the output bytes
  reg [2:0] state;        // State register to keep track of the state
  wire bit3 = in[2];      // Third bit of the input
  
  // Sequential logic: update the state and output register on the rising edge of the clock
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 0;    // Initialize state to 0 when reset is asserted
    else begin
      case(state)
        3'b000: begin
          if (bit3)
            state <= 3'b001;  // Transition to BYTE2 if bit3 is 1
          else
            state <= 3'b000;  // Stay in BYTE1 if bit3 is 0
        end
        3'b001: begin
          state <= 3'b010;    // Transition to BYTE3
        end
        3'b010: begin
          state <= 3'b011;    // Transition to DONE
        end
        3'b011: begin
          state <= 3'b000;    // Transition to BYTE1
        end
      endcase
    end
  end
  
  // Combinational logic: compute the output
  always @* begin
    case(state)
      3'b000: begin
        done = 1'b0;                    // done signal is 0 in BYTE1
        out_reg = {in, out_reg[23:8]};   // Shift in the input and shift left by 8 bits
      end
      3'b001: begin
        done = 1'b0;                    // done signal is 0 in BYTE2
        out_reg = {8'b0, out_reg[23:8]}; // Shift left by 8 bits
      end
      3'b010: begin
        done = 1'b0;                    // done signal is 0 in BYTE3
        out_reg = {16'b0, out_reg[23:8]}; // Shift left by 8 bits
      end
      3'b011: begin
        done = 1'b1;                    // done signal is 1 in DONE
        out_reg = {8'b0, out_reg[23:8]}; // Shift left by 8 bits
      end
    endcase
  end
  
  // Assign the output
  assign out_bytes = out_reg;
endmodule
