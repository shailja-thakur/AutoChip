module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
  
    // State declaration
    typedef enum logic [1:0] {
        STATE_WAIT     = 2'b00, // Waiting for start of message byte
        STATE_BYTE1    = 2'b01, // First byte received
        STATE_BYTE2    = 2'b10, // Second byte received
        STATE_BYTE3    = 2'b11  // Third byte received
    } state_t;
  
    state_t current_state, next_state;
    logic done_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= STATE_WAIT;
        else
            current_state <= next_state;
    end

    // Next state logic and done signal
    always_comb begin
        // Default values
        next_state = current_state;
        done_reg = 1'b0;
        
        case (current_state)
            STATE_WAIT: begin
                if (in[3] == 1'b1) // Detect first byte
                    next_state = STATE_BYTE1;
            end
            STATE_BYTE1: begin
                next_state = STATE_BYTE2;
            end
            STATE_BYTE2: begin
                next_state = STATE_BYTE3;
            end
            STATE_BYTE3: begin
                done_reg = 1'b1; // Signal done
                next_state = STATE_WAIT;
            end
        endcase
    end
  
    // Output logic
    assign done = done_reg;
  
endmodule
