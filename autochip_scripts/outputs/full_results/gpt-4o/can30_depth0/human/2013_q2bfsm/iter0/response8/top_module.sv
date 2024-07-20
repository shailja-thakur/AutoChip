module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
    // State encoding
    typedef enum logic [2:0] {
        STATE_A, 
        STATE_B,
        STATE_C, 
        STATE_D, 
        STATE_E,
        STATE_F
    } state_t;
    
    state_t state, next_state;
    logic [1:0] x_seq; // to hold the sequence of x values (01x)

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
        end else begin
            case (state)
                STATE_A: begin
                    f <= 1; // Set f for one clock cycle
                    g <= 0;
                end
                STATE_B: f <= 0; // Clear f after the clock cycle
                default: f <= 0;
            endcase
            
            // Set g whenever in STATE_E or STATE_F
            if (state == STATE_E || state == STATE_F)
                g <= 1;
            else
                g <= 0;
        end
    end

    always_comb begin
        next_state = state; // Default to remain in the same state
        case (state)
            STATE_A: begin
                // Wait for reset to be deasserted
                if (resetn) next_state = STATE_B;
            end
            
            STATE_B: begin
                // Move to checking x sequence
                next_state = STATE_C;
            end
            
            STATE_C: begin
                // Start checking the x sequence 1, 0, 1
                if (x == 1) begin
                    x_seq <= 1;
                    next_state = STATE_D;
                end
            end
            
            STATE_D: begin
                if (x_seq == 1 && x == 0) begin
                    next_state = STATE_E;
                end else begin
                    x_seq <= 0; // Condition fails, start checking again
                    next_state = STATE_C;
                end
            end
            
            STATE_E: begin
                if (x == 1 && x_seq == 0) begin
                    next_state = STATE_F;
                end else begin
                    x_seq <= 1; // Move back to check for the first 1
                    next_state = STATE_D;
                end
            end
            
            STATE_F: begin
                // Check y input for two cycles
                if (y == 1) next_state = STATE_F;
                else next_state = STATE_A; // Reset if not met within two cycles
            end
            
            default: next_state = STATE_A; // Default case
        endcase
    end
endmodule
