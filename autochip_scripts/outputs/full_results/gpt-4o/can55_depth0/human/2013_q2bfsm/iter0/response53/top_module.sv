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
        STATE_F = 3'b001,
        STATE_MONITOR_X = 3'b010,
        STATE_G_SET = 3'b011,
        STATE_MONITOR_Y = 3'b100,
        STATE_G_CLEAR = 3'b101
    } state_t;
    
    // State, X counter, Y counter declaration
    state_t state, next_state;
    reg [1:0] x_counter, y_counter;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
            x_counter <= 0;
            y_counter <= 0;
            f <= 0;
            g <= 0;
        end 
        else begin
            state <= next_state;
            if (state == STATE_MONITOR_X)
                x_counter <= (x_counter == 2) ? 0 : x_counter + 1;
            if (state == STATE_MONITOR_Y)
                y_counter <= (y_counter == 2) ? 0 : y_counter + 1;
    
            f <= (state == STATE_F);
            if (state == STATE_G_SET) 
                g <= 1;
            else if (state == STATE_G_CLEAR)
                g <= 0;
        end
    end
    
    always @(*) begin
        next_state = state;
        case (state)
            STATE_A: begin
                if (resetn)
                    next_state = STATE_F;
            end
            STATE_F: begin
                next_state = STATE_MONITOR_X;
            end
            STATE_MONITOR_X: begin
                if (x_counter == 2) begin
                    if (x) 
                        next_state = STATE_G_SET;
                    else
                        next_state = STATE_MONITOR_X;
                end
            end
            STATE_G_SET: begin
                next_state = STATE_MONITOR_Y;
            end
            STATE_MONITOR_Y: begin
                if (y) 
                    next_state = STATE_G_SET;  // Keep g = 1
                else if (y_counter == 1)
                    next_state = STATE_G_CLEAR;
            end
            STATE_G_CLEAR: begin
                // Maintain g set to 0 until reset
            end
            default: begin
                next_state = STATE_A; // Default state
            end
        endcase
    end
endmodule
