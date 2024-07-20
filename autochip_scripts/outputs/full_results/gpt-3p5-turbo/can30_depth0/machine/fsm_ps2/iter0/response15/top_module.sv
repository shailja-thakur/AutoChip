module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  // State definition
  typedef enum logic [1:0] {
    BYTE1,
    BYTE2,
    BYTE3,
    DONE
  } state_t;

  state_t current_state, next_state;

  // Next state logic
  always_ff @(posedge clk) begin
    if (reset) begin
      current_state <= BYTE1;
    end else begin
      current_state <= next_state;
    end
  end

  // Output logic
  always_comb begin
    case (current_state)
      BYTE1: begin
        if (in[2] == 1'b1) begin
          next_state = BYTE2;
        end else begin
          next_state = BYTE1;
        end
      end
      
      BYTE2: begin
        next_state = BYTE3;
      end
      
      BYTE3: begin
        next_state = DONE;
      end
      
      DONE: begin
        if (in[2] == 1'b1) begin
          next_state = BYTE2;
        end else begin
          next_state = BYTE1;
        end
      end
    endcase
  end

  // Done output logic
  assign done = (current_state == DONE);

endmodule
