module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // State declaration
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count; // Count the number of 1's observed in state B

    // State transition on clock edge
    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_A;
            w_count <= 0;
            z <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state; // Default to hold state
        case (state)
            STATE_A: begin
                if (s)
                    next_state = STATE_B;
            end
            STATE_B: begin
                // We need to count the w input for three cycles
                if ((w_count == 2'b10) || (w_count == 2'b11)) begin
                    // If w is 1 for exactly 2 cycles within these 3 clock cycles
                    if (w_count == 2'b10)
                        z = 1;
                    else
                        z = 0;
                    
                    next_state = STATE_C;  // Move to the next state to reset the counter
                end
            end
            STATE_C: begin
                w_count = 0;  // Reset the counter
                z = 0;  // Reset the output
                next_state = STATE_B;
            end
        endcase
    end

    // w counter logic
    always @(posedge clk) begin
        if (state == STATE_B) begin
            w_count = w_count + w;
        end
    end

endmodule
