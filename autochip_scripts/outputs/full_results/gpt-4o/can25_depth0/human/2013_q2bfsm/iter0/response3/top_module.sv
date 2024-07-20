module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State declaration
    typedef enum reg [3:0] {
        STATE_A = 4'b0000,
        STATE_B = 4'b0001,
        STATE_C = 4'b0010,
        STATE_D = 4'b0011,
        STATE_E = 4'b0100,
        STATE_F = 4'b0101,
        STATE_G = 4'b0110,
        STATE_H = 4'b0111,
        STATE_I = 4'b1000,
        STATE_J = 4'b1001
    } state_t;
 
    state_t state, next_state;

    // Sequential logic for state transitions
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Combinational logic for next state and outputs
    always @(*) begin
        // Default values
        next_state = state;
        f = 0;
        g = 0;

        case (state)
            STATE_A: begin
                if (!resetn)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end

            STATE_B: begin
                f = 1;
                next_state = STATE_C;
            end

            STATE_C: begin
                if (x)
                    next_state = STATE_D;
                else
                    next_state = STATE_C;
            end

            STATE_D: begin
                if (!x)
                    next_state = STATE_E;
                else
                    next_state = STATE_C;
            end

            STATE_E: begin
                if (x)
                    next_state = STATE_F;
                else
                    next_state = STATE_C;
            end

            STATE_F: begin
                g = 1;
                next_state = STATE_G;
            end

            STATE_G: begin
                if (y)
                    next_state = STATE_I;
                else
                    next_state = STATE_H;
            end
            
            STATE_H: begin
                if (y) begin
                    g = 1;
                    next_state = STATE_I;
                end
                else
                    next_state = STATE_J;
            end

            STATE_I: begin
                g = 1;
                next_state = STATE_I;
            end
            
            STATE_J: begin
                g = 0;
                next_state = STATE_J;
            end
            
            default: begin
                next_state = STATE_A;
            end

        endcase
    end

endmodule
