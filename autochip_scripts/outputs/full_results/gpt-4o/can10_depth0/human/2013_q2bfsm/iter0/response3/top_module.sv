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
        STATE_A = 3'd0,  // Beginning state
        STATE_F = 3'd1,  // State to set f = 1 for one clock cycle
        STATE_X1 = 3'd2, // State for x = 1
        STATE_X0 = 3'd3, // State for x = 0
        STATE_X2 = 3'd4, // State for next x = 1
        STATE_G1 = 3'd5, // State to set g = 1
        STATE_Y_WAIT1 = 3'd6, // State to wait for y value 1 (1st clock cycle)
        STATE_Y_WAIT2 = 3'd7  // State to wait for y value 1 (2nd clock cycle)
    } state_t;

    reg [2:0] current_state, next_state;

    // State transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        // Default values
        next_state = current_state;
        f = 1'b0;
        g = 1'b0;

        case (current_state)
            STATE_A: begin
                if (resetn)
                    next_state = STATE_F;
            end
            STATE_F: begin
                f = 1'b1;
                next_state = STATE_X1;
            end
            STATE_X1: begin
                if (x == 1)
                    next_state = STATE_X0;
                else
                    next_state = STATE_X1;
            end
            STATE_X0: begin
                if (x == 0)
                    next_state = STATE_X2;
                else
                    next_state = STATE_X1;
            end
            STATE_X2: begin
                if (x == 1)
                    next_state = STATE_G1;
                else
                    next_state = STATE_X1;
            end
            STATE_G1: begin
                g = 1'b1;
                next_state = STATE_Y_WAIT1;
            end
            STATE_Y_WAIT1: begin
                g = 1'b1;
                if (y == 1)
                    next_state = STATE_G1;
                else
                    next_state = STATE_Y_WAIT2;
            end
            STATE_Y_WAIT2: begin
                g = 1'b1;
                if (y == 1)
                    next_state = STATE_G1;
                else
                    next_state = STATE_A;
            end
            default: next_state = STATE_A;
        endcase
    end

    // Output assignment
    assign f = (current_state == STATE_F);
    assign g = (current_state == STATE_G1 || current_state == STATE_Y_WAIT1 || current_state == STATE_Y_WAIT2);

endmodule
