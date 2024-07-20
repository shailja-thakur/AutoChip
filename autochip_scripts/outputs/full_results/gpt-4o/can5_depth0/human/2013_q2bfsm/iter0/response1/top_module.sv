module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;
    
    state_t state, next_state;
    reg [1:0] y_counter;

    // Synchronous state transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        // Default values
        next_state = state;
        f = 0;
        g = 0;
        case (state)
            STATE_A: begin
                if (resetn)
                    next_state = STATE_B;
            end
            STATE_B: begin
                f = 1;
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x == 1'b1)
                    next_state = STATE_D;
            end
            STATE_D: begin
                if (x == 1'b0)
                    next_state = STATE_E;
                else
                    next_state = STATE_C;
            end
            STATE_E: begin
                if (x == 1'b1)
                    next_state = STATE_F;
                else
                    next_state = STATE_C;
            end
            STATE_F: begin
                g = 1;
                if (y == 1'b1)
                    y_counter = 2'b00; // Reset y counter on seeing y = 1
                else if (y_counter < 2'b10) begin
                    y_counter = y_counter + 1;
                end
                else begin
                    g = 0; 
                end
                // Remain in STATE_F with g = 1 until reset if y becomes 1 within two cycles
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end
endmodule
