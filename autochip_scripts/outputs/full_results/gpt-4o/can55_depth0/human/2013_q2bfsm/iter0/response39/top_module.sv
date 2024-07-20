module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum logic [2:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_D,
        STATE_E,
        STATE_F,
        STATE_G
    } state_t;

    state_t state, next_state;
    reg [1:0] y_counter;  // Counter for y input monitoring
    reg [2:0] x_sequence; // To store the last three x values

    // State transitions
    always_ff @(posedge clk) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state; // Default to stay in current state
        case (state)
            STATE_A: if (!resetn) next_state = STATE_B;
            STATE_B: next_state = STATE_C;
            STATE_C: next_state = STATE_D;
            STATE_D: next_state = STATE_E;
            STATE_E: if (x_sequence == 3'b101) next_state = STATE_F;
            STATE_F: if (y_counter == 2 || y) next_state = STATE_G;
            STATE_G: ; // Remain in this state
            default: next_state = STATE_A;
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
            y_counter <= 0;
            x_sequence <= 0;
        end else begin
            case (state)
                STATE_A: begin
                    f <= 0;
                    g <= 0;
                    y_counter <= 0;
                    x_sequence <= 0;
                end
                STATE_B: f <= 1;
                STATE_C: f <= 0;
                STATE_D: f <= 0;
                STATE_E: begin
                    x_sequence <= {x_sequence[1:0], x};
                end
                STATE_F: begin
                    if (y) begin
                        g <= 1;
                    end else if (y_counter >= 2) begin
                        g <= 0;
                    end else begin
                        y_counter <= y_counter + 1;
                    end
                end
                STATE_G: begin
                    g <= g; // Maintain g value
                end
            endcase
        end
    end
endmodule
