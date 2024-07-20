module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State declaration
    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;

    state_t state, next_state;

    // Internal registers for monitoring input sequences
    reg [1:0] y_counter;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            y_counter <= 2'b00;
        end else begin
            state <= next_state;
            if (next_state == STATE_B) f <= 1'b1;
            else f <= 1'b0;
            if (next_state == STATE_E) g <= 1'b1;
            else if (next_state == STATE_F) g <= 1'b0;
        end
    end

    // State transition logic
    always @(*) begin
        next_state = state;
        case (state)
            STATE_A: begin
                // Initial state, wait until resetn is de-asserted
                if (!resetn) 
                    next_state = STATE_A;
                else 
                    next_state = STATE_B;
            end
            STATE_B: begin
                // Move from state B to state C after setting f to 1 for one clock cycle
                next_state = STATE_C;
            end
            STATE_C: begin
                // Monitor x input for 101 sequence
                if (x == 1'b1)
                    next_state = STATE_D;
            end
            STATE_D: begin
                if (x == 1'b0)
                    next_state = STATE_E;
            end
            STATE_E: begin
                if (x == 1'b1)
                    next_state = STATE_F;
            end
            STATE_F: begin
                // Monitor y input while g is 1
                if (y_counter < 2'b10 && y == 1'b1)
                    g <= 1'b1;
                else if (y_counter == 2'b10 && y != 1'b1)
                    g <= 1'b0;
                
                if (y_counter < 2'b10) y_counter = y_counter + 1;
                
                // Maintain state F
                next_state = STATE_F;
            end
            default: next_state = STATE_A;
        endcase
    end

endmodule
