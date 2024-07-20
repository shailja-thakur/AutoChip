module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting
);
  
  reg [2:0] state; // Register to hold the current state of the state machine
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b001; // Reset state to S
      start_shifting <= 1'b0; // Set output to low
    end else begin
      case (state)
        3'b001: begin // S state
          if (data) begin
            state <= 3'b010; // Next state is S1
            start_shifting <= 1'b0;
          end else begin
            state <= 3'b001; // Next state is S
            start_shifting <= 1'b0;
          end
        end
        3'b010: begin // S1 state
          if (data) begin
            state <= 3'b011; // Next state is S11
            start_shifting <= 1'b0;
          end else begin
            state <= 3'b001; // Next state is S
            start_shifting <= 1'b0;
          end
        end
        3'b011: begin // S11 state
          if (data) begin
            state <= 3'b011; // Next state is S11
            start_shifting <= 1'b0;
          end else begin
            state <= 3'b100; // Next state is S110
            start_shifting <= 1'b0;
          end
        end
        3'b100: begin // S110 state
          if (data) begin
            state <= 3'b101; // Next state is Done
            start_shifting <= 1'b1; // Set output to high
          end else begin
            state <= 3'b001; // Next state is S
            start_shifting <= 1'b0;
          end
        end
        3'b101: begin // Done state
          state <= 3'b101; // Next state is Done
          start_shifting <= 1'b1; // Set output to high
        end
      endcase
    end
  end

endmodule
