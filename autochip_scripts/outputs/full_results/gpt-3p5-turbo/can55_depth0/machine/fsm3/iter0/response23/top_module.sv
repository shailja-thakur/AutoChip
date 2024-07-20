module top_module (
  input clk,
  input in,
  input areset,
  output reg out
);

  reg [1:0] state;
  reg [1:0] next_state;
  
  always @(posedge clk) begin
    if (areset) begin
      state <= 2'b00; // Reset to state A
    end
    else begin
      state <= next_state; // Update state on rising edge of clk
    end
  end
  
  always @(state, in) begin
    case(state)
      2'b00: begin // Current state is A
        if (in) begin // Next state is B if in = 1, A if in = 0
          next_state = 2'b01;
        end
        else begin
          next_state = 2'b00;
        end
      end
      
      2'b01: begin // Current state is B
        if (in) begin // Next state is B if in = 1, C if in = 0
          next_state = 2'b01;
        end
        else begin
          next_state = 2'b10;
        end
      end
      
      2'b10: begin // Current state is C
        if (in) begin // Next state is D if in = 1, A if in = 0
          next_state = 2'b11;
        end
        else begin
          next_state = 2'b00;
        end
      end
      
      2'b11: begin // Current state is D
        if (in) begin // Next state is B if in = 1, C if in = 0
          next_state = 2'b01;
        end
        else begin
          next_state = 2'b10;
        end
      end
    endcase
  end
  
  assign out = (state == 2'b11); // Set out to 1 when state is D

endmodule
