module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // Define state variables
    typedef enum reg [2:0] {
        STATE_A = 3'b000, 
        STATE_B = 3'b001, 
        STATE_C = 3'b010, 
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101,
        STATE_G = 3'b110,
        STATE_H = 3'b111
    } state_t;

    state_t state, next_state;
    reg [1:0] y_counter;
    reg [2:0] x_pattern;
    
    // State transition
    always @(posedge clk or negedge resetn) 
    begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always @(*) 
    begin
        // Defaults
        next_state = state;
        f = 0;
        g = 0;

        case (state)
            STATE_A: 
            begin
                if (!resetn)
                begin
                    next_state = STATE_A;
                end
                else
                begin
                    next_state = STATE_B;
                    f = 1;
                end
            end
            STATE_B: 
            begin
                next_state = STATE_C;
            end
            STATE_C: 
            begin
                x_pattern[2] = x_pattern[1];
                x_pattern[1] = x_pattern[0];
                x_pattern[0] = x;

                if (x_pattern == 3'b101)
                begin
                    next_state = STATE_D;
                end
            end
            STATE_D: 
            begin
                g = 1;
                next_state = STATE_E;
            end
            STATE_E: 
            begin
                g = 1;
                if (y)
                begin
                    next_state = STATE_H;
                end
                else
                begin
                    y_counter = 0;
                    next_state = STATE_F;
                end
            end
            STATE_F: 
            begin
                g = 1;
                y_counter = y_counter + 1;

                if (y)
                begin
                    next_state = STATE_H;
                end
                else if (y_counter == 2)
                begin
                    next_state = STATE_G;
                end
            end
            STATE_G: 
            begin
                g = 0;
            end
            STATE_H: 
            begin
                g = 1;
            end
            default: 
            begin
                next_state = STATE_A;
            end
        endcase
    end
endmodule
