module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

    typedef enum reg [2:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_D,
        STATE_E,
        STATE_F,
        STATE_G,
        STATE_H
    } state_type;

    state_type state, next_state;
    reg [1:0] y_counter;

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state; // Default to stay in the same state
        f = 0; // Default to f being 0
        g = 0; // Default to g being 0
        case (state)
            STATE_A: begin
                if (resetn) next_state = STATE_B;
            end
            STATE_B: begin
                next_state = STATE_C;
                f = 1;
            end
            STATE_C: begin
                if (x == 1) next_state = STATE_D;
            end
            STATE_D: begin
                if (x == 0) next_state = STATE_E;
                else next_state = STATE_C; // Remain in the same state if condition fails
            end
            STATE_E: begin
                if (x == 1) next_state = STATE_F;
                else next_state = STATE_C; // Remain in the same state if condition fails
            end
            STATE_F: begin
                g = 1;
                next_state = STATE_G;
            end
            STATE_G: begin
                g = 1;
                if (y == 1) next_state = STATE_H;
                else if (y_counter == 2) next_state = STATE_A;
                else y_counter = y_counter + 1;
            end
            STATE_H: begin
                g = 1;
            end
            default: next_state = STATE_A; // Go to initial state in default
        endcase
    end
    
    // Handle y counter reset on state change
    always @(state) begin
        if (state != STATE_G) y_counter <= 0;
    end

endmodule
