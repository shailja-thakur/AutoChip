module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State definitions
    typedef enum logic [2:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_D,
        STATE_E,
        STATE_F,
        STATE_G
    } state_t;

    state_t state, next_state;
    logic [1:0] x_sequence_counter;
    logic [1:0] y_monitor_counter;

    // State transition
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Output logic and next state logic
    always_comb begin
        // Default outputs
        f = 0;
        g = 0;
        next_state = state;

        case (state)
            STATE_A: begin
                if (resetn == 1)
                    next_state = STATE_B;
            end
            STATE_B: begin
                f = 1;
                next_state = STATE_C;
            end
            STATE_C: begin
                f = 0;
                if (x == 1)
                    next_state = STATE_D;
            end
            STATE_D: begin
                if (x == 0)
                    next_state = STATE_E;
                else
                    next_state = STATE_C;
            end
            STATE_E: begin
                if (x == 1)
                    next_state = STATE_F;
                else
                    next_state = STATE_C;
            end
            STATE_F: begin
                g = 1;
                next_state = STATE_G;
            end
            STATE_G: begin
                g = 1;
                if (y == 1)
                    next_state = STATE_G;
                else if (y_monitor_counter == 1) begin
                    g = 1;
                end
                else if (y_monitor_counter == 2) begin
                    g = 0;
                    next_state = STATE_A;
                end
            end
        endcase
    end

    // Counter for x sequence
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            x_sequence_counter <= 0;
        else if (state == STATE_C)
            x_sequence_counter <= 1;
        else if (state == STATE_D)
            x_sequence_counter <= 2;
        else if (state == STATE_E)
            x_sequence_counter <= 0;
    end

    // Counter for y monitoring
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            y_monitor_counter <= 0;
        else if (state == STATE_G && y != 1)
            y_monitor_counter <= y_monitor_counter + 1;
        else
            y_monitor_counter <= 0;
    end

endmodule
