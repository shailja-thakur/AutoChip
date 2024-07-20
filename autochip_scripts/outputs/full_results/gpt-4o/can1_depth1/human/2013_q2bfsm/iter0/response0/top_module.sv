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
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;

    state_t state, next_state;
    reg [1:0] y_counter; // Counter for checking y input within two clock cycles

    // State transition
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
                if (!resetn) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                    f = 1;
                end
            end

            STATE_B: begin
                next_state = STATE_C;
            end

            STATE_C: begin
                if (x == 1)
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            end

            STATE_D: begin
                if (x == 0)
                    next_state = STATE_E;
                else
                    next_state = STATE_A;
            end

            STATE_E: begin
                if (x == 1)
                    next_state = STATE_F;
                else
                    next_state = STATE_A;
            end

            STATE_F: begin
                g = 1;
                y_counter = 2;
                next_state = (y == 1) ? STATE_F : STATE_A;
            end

            default: begin
                next_state = STATE_A;
            end
        endcase
    end

    // Output logic and counter update
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
            y_counter <= 0;
        end else begin
            if (state == STATE_A)
                f <= 0;
            else if (state == STATE_F) begin
                g <= 1;
                if (y_counter != 0) begin
                    y_counter <= y_counter - 1;
                    if (y == 1)
                        y_counter <= 0; // Freeze g=1 permanently
                end else
                    g <= 1;
            end else
                g <= 0;
        end
    end

endmodule
