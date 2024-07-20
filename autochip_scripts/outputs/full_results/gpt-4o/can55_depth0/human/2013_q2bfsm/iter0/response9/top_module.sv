module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum logic[2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;

    state_t state, next_state;
    reg [1:0] count;
    reg [2:0] x_sequence;

    // State transition logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always_comb begin
        next_state = state;
        f = 0;
        g = 0;
        case (state)
            STATE_A: begin
                if (resetn) 
                    next_state = STATE_B;
            end
            STATE_B: begin
                next_state = STATE_C;
                f = 1;
            end
            STATE_C: begin
                if (x) 
                    x_sequence = (x_sequence << 1) | x;
                else
                    x_sequence = x_sequence << 1;

                if (x_sequence == 3'b101) 
                    next_state = STATE_D;
            end
            STATE_D: begin
                g = 1;
                next_state = STATE_E;
                count = 2;
            end
            STATE_E: begin
                g = 1;
                if (y) 
                    next_state = STATE_F;
                else if (count == 0) 
                    g = 0;
                    next_state = STATE_A;
                else 
                    count = count - 1;
            end
            STATE_F: begin
                g = 1;
            end
        endcase
    end

endmodule
