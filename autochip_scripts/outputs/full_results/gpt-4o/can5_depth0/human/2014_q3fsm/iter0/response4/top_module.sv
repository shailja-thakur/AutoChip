module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,   // Initial state
        STATE_B = 2'b01,   // Start monitoring w
        STATE_C = 2'b10,   // Monitor w cycle 1
        STATE_D = 2'b11    // Monitor w cycle 2
    } state_t;

    state_t state, next_state;
    reg [1:0] w_count; // Counter for number of 1's in w

    // State transition logic (combinational)
    always @(*) begin
        next_state = state;
        z = 0; // Default output value
        
        case (state)
            STATE_A: begin
                if (s)
                    next_state = STATE_B;
            end
            STATE_B: next_state = STATE_C;
            STATE_C: next_state = STATE_D;
            STATE_D: begin
                if (w_count == 2)
                    z = 1;
                next_state = STATE_B; // Restart monitoring w
            end
            default: next_state = STATE_A;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_A;
            w_count <= 0;
        end else begin
            state <= next_state;
            if (next_state == STATE_C || next_state == STATE_D) begin
                if (w)
                    w_count <= w_count + 1;
            end else if (next_state == STATE_B) begin
                // Reset counter when we re-enter STATE_B
                w_count <= 0;
            end
        end
    end

endmodule
