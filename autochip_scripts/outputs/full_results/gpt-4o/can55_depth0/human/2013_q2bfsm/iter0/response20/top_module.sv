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
        STATE_A = 3'b000,
        STATE_F = 3'b001,
        STATE_X1 = 3'b010,
        STATE_X0 = 3'b011,
        STATE_X1_FINAL = 3'b100,
        STATE_G_CHECK = 3'b101,
        STATE_G_PERMANENT = 3'b110
    } state_t;
    
    state_t state, next_state;
    reg [1:0] y_counter; // Counter for y input state check
    
    // State transition logic
    always @(*) begin
        next_state = state;
        case (state)
            STATE_A: begin
                f = 0;
                g = 0;
                if (!resetn)
                    next_state = STATE_F;
            end
            STATE_F: begin
                f = 1;
                g = 0;
                next_state = STATE_X1;
            end
            STATE_X1: begin
                f = 0;
                g = 0;
                if (x)
                    next_state = STATE_X0;
            end
            STATE_X0: begin
                f = 0;
                g = 0;
                if (!x)
                    next_state = STATE_X1_FINAL;
            end
            STATE_X1_FINAL: begin
                f = 0;
                g = 0;
                if (x)
                    next_state = STATE_G_CHECK;
            end
            STATE_G_CHECK: begin
                f = 0;
                g = 1;
                if (y) begin
                    next_state = STATE_G_PERMANENT;
                end else if (y_counter == 2) begin
                    next_state = STATE_A;
                end
                // otherwise stay in G_CHECK state
            end
            STATE_G_PERMANENT: begin
                f = 0;
                g = 1;
            end
        endcase
    end
    
    // State register and output logic
    always @(posedge clk) begin
        if (resetn) begin
            state <= STATE_A;
            y_counter <= 0;
        end else begin
            state <= next_state;
            // Update y_counter only in G_CHECK state
            if (state == STATE_G_CHECK && !y) begin
                y_counter <= y_counter + 1;
            end
            // Reset y_counter in other states
            if (state != STATE_G_CHECK) begin
                y_counter <= 0;
            end
        end
    end
    
endmodule
