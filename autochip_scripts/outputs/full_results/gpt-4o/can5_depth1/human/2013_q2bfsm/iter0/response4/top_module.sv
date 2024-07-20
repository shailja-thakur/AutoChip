module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
    // Define state encoding
    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_F = 3'b001,
        STATE_X1 = 3'b010,
        STATE_X0 = 3'b011,
        STATE_X1_REPEATED = 3'b100,
        STATE_WAIT_Y1 = 3'b101,
        STATE_G1 = 3'b110,
        STATE_G0 = 3'b111
    } state_t;
    
    state_t state, next_state;
    logic [1:0] y_counter;
    
    // State transition
    always_ff @(posedge clk) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        // Default values
        next_state = state;
        f = 1'b0;
        g = 1'b0;
        case (state)
            STATE_A: begin
                if (!resetn)
                    next_state = STATE_F;
            end
            STATE_F: begin
                f = 1'b1;
                next_state = STATE_X1;
            end
            STATE_X1: begin
                if (x)
                    next_state = STATE_X0;
            end
            STATE_X0: begin
                if (!x)
                    next_state = STATE_X1_REPEATED;
            end
            STATE_X1_REPEATED: begin
                if (x)
                    next_state = STATE_WAIT_Y1;
            end
            STATE_WAIT_Y1: begin
                g = 1'b1;
                if (y)
                    next_state = STATE_G1;
                else if (y_counter == 2'b10)
                    next_state = STATE_G0;
            end
            STATE_G1: begin
                g = 1'b1;
            end
            STATE_G0: begin
                g = 1'b0;
            end
        endcase
    end

    // Y counter logic
    always_ff @(posedge clk) begin
        if (state == STATE_WAIT_Y1)
            y_counter <= y_counter + 1;
        else
            y_counter <= 2'b00;
    end
endmodule
