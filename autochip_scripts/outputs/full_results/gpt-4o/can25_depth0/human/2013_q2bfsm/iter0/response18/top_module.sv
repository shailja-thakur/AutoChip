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
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_D,
        STATE_E,
        STATE_F
    } state_t;

    state_t state, next_state;
    reg [1:0] y_counter;

    // State transition and output logic
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= STATE_A;
            f <= 0;
            g <= 0;
            y_counter <= 0;
        end else begin
            state <= next_state;
            case (state)
                STATE_A: begin
                    f <= 0;
                    g <= 0;
                end
                STATE_B: begin
                    f <= 1;
                end
                STATE_C: begin
                    f <= 0;
                end
                STATE_E: begin
                    if (y == 1) begin
                        g <= 1;
                    end
                end
                STATE_F: begin
                    if (y_counter < 2) begin
                        y_counter <= y_counter + 1;
                        if (y == 1) begin
                            g <= 1;
                        end else begin
                            g <= 0;
                        end
                    end else begin
                        g <= 0;
                    end
                end
            endcase
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            STATE_A: begin
                if (~resetn) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x == 1) begin
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_C;
                end
            end
            STATE_D: begin
                if (x == 0) begin
                    next_state = STATE_E;
                end else begin
                    next_state = STATE_C;
                end
            end
            STATE_E: begin
                if (x == 1) begin
                    next_state = STATE_F;
                end else begin
                    next_state = STATE_C;
                end
            end
            STATE_F: begin
                if (g == 0) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_F;
                end
            end
        endcase
    end

endmodule
