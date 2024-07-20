module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
    typedef enum reg [2:0] {
        STATE_A,    // Initial state when reset is asserted
        STATE_F,    // State where f is set to 1
        STATE_X1,   // State waiting for x sequence 1
        STATE_X0,   // State waiting for x sequence 0
        STATE_X1_2, // State waiting for x to be 1 again
        STATE_G,    // State where g is set to 1
        STATE_Y     // State waiting for y input
    } state_t;
    
    state_t current_state, next_state;
    reg [1:0] y_count; // Counter for y input sequence

    // State transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        // Default values for outputs
        next_state = current_state;
        f = 0;
        case (current_state)
            STATE_A: begin
                if (!resetn)
                    next_state = STATE_F;
            end
            STATE_F: begin
                f = 1;
                next_state = STATE_X1;
            end
            STATE_X1: begin
                if (x)
                    next_state = STATE_X0;
                else
                    next_state = STATE_X1;
            end
            STATE_X0: begin
                if (!x)
                    next_state = STATE_X1_2;
                else
                    next_state = STATE_X1;
            end
            STATE_X1_2: begin
                if (x)
                    next_state = STATE_G;
                else
                    next_state = STATE_X1;
            end
            STATE_G: begin
                g = 1;
                next_state = STATE_Y;
            end
            STATE_Y: begin
                g = 1;
                if (y) begin
                    next_state = STATE_Y; // Remain here if y becomes 1
                end else if (y_count == 2) begin
                    next_state = STATE_A;
                end else begin
                    y_count = y_count + 1;
                    next_state = STATE_Y;
                end
            end
        endcase
    end

endmodule
