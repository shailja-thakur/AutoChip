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
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;
    
    state_t state, next_state;
    
    // State transition based on current state and inputs
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // State transitions and output logic
    always_comb begin
        // Default values
        next_state = state;
        f = 1'b0;
        g = 1'b0;

        case (state)
            STATE_A: begin
                if (resetn == 1'b1)
                    next_state = STATE_B;
            end
            STATE_B: begin
                f = 1'b1;
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x == 1'b1)
                    next_state = STATE_D;
                else
                    next_state = STATE_C;
            end
            STATE_D: begin
                if (x == 1'b0)
                    next_state = STATE_E;
                else
                    next_state = STATE_C;
            end
            STATE_E: begin
                if (x == 1'b1) begin
                    next_state = STATE_F;
                end else begin
                    next_state = STATE_C;
                end
            end
            STATE_F: begin
                g = 1'b1;
                if (y == 1'b1) begin
                    next_state = STATE_F;
                end else if (y == 1'b0) begin
                    next_state = STATE_A;
                end
            end
            default: next_state = STATE_A;
        endcase
    end

    // Output assignment based on current state
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f <= 1'b0;
            g <= 1'b0;
        end else begin
            if (state == STATE_B)
                f <= 1'b1;
            else if (state == STATE_F)
                g <= 1'b1;
        end
    end

endmodule
