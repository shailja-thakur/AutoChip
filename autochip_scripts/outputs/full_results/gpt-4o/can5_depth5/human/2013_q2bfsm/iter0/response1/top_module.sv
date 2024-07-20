module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101,
        STATE_G = 3'b110
    } state_t;

    state_t state, next_state;
    reg [1:0] counter;

    // Reset and state transition logic
    always @(posedge clk) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            STATE_A: if (~resetn) next_state = STATE_B;
            STATE_B: next_state = STATE_C;
            STATE_C: if (x) next_state = STATE_D;
            STATE_D: if (!x) next_state = STATE_E;
            STATE_E: if (x) next_state = STATE_F;
            STATE_F:                                          // Waiting for y input
                if (y) next_state = STATE_G;
                else if (counter == 2'b10) next_state = STATE_A;
            STATE_G: if (~resetn) next_state = STATE_A;
            default: next_state = STATE_A;
        endcase
    end

    // Output and counter logic
    always @(posedge clk) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
            counter <= 2'b00;
        end else begin
            case (state)
                STATE_A: begin
                    f <= 0;
                    g <= 0;
                    counter <= 2'b00;
                end
                STATE_B: begin
                    f <= 1;
                end
                STATE_C: begin
                    f <= 0;
                end
                STATE_D: ;
                STATE_E: ;
                STATE_F: begin
                    if (next_state == STATE_F) begin
                        counter <= counter + 1;
                    end
                end
                STATE_G: g <= 1;
            endcase

            // Maintain g=1 if condition met
            if (state == STATE_F && y)
                g <= 1;
        
            // Reset g if condition not met within 2 cycles
            if (state == STATE_F && counter == 2'b10 && !y)
                g <= 0;
        end
    end
endmodule
