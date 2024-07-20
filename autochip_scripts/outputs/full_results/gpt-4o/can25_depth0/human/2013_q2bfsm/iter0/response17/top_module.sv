module top_module (
    input clk,
    input resetn,  // Active low reset
    input x,
    input y,
    output reg f,
    output reg g
);

    // State declaration
    typedef enum reg [2:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_D,
        STATE_E,
        STATE_F,
        STATE_G,
        STATE_H
    } state_t;

    state_t current_state, next_state;

    // State transition and output logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output assignments
    always @(*) begin
        // Default assignments to avoid latches
        next_state = current_state;
        f = 0;
        g = 0;

        case (current_state)
            STATE_A: begin
                if (!resetn) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                    f = 1;
                end
            end

            STATE_B: begin
                f = 0; // Ensure `f` is 1 for one clock cycle in STATE_A
                if (x) next_state = STATE_C;
                else    next_state = STATE_B;
            end

            STATE_C: begin
                if (~x) next_state = STATE_D;
                else    next_state = STATE_B;
            end

            STATE_D: begin
                if (x) next_state = STATE_E;
                else    next_state = STATE_B;
            end

            STATE_E: begin
                g = 1;
                if (y) next_state = STATE_G;
                else    next_state = STATE_F;
            end

            STATE_F: begin
                g = 1;
                if (y) next_state = STATE_G;
                else    next_state = STATE_H;
            end

            STATE_G: begin
                g = 1; // Maintain `g = 1` permanently
                next_state = STATE_G;
            end

            STATE_H: begin
                g = 0; // Set `g = 0` permanently
                next_state = STATE_H;
            end

            default: next_state = STATE_A;
        endcase
    end
endmodule
