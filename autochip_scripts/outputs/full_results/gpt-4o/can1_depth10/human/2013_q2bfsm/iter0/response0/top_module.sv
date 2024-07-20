module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum reg [2:0] {
        STATE_A = 3'd0,
        STATE_B = 3'd1,
        STATE_C = 3'd2,
        STATE_D = 3'd3,
        STATE_E = 3'd4,
        STATE_F = 3'd5,
        STATE_G = 3'd6
    } state_t;

    state_t state, next_state;
    reg [1:0] x_monitor;        // To monitor the sequence x = 1, 0, 1
    reg [1:0] y_monitor;        // To monitor the sequence y within 2 cycles

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= STATE_A;
            f <= 0;
            g <= 0;
            x_monitor <= 0;
            y_monitor <= 0;
        end else begin
            state <= next_state;
            if (state == STATE_B) f <= 1;
            else f <= 0;
            if (state == STATE_E) g <= 1;
            else if (state == STATE_F) g <= 1;
            else if (state == STATE_G) g <= 0;
            x_monitor <= x_monitor >> 1;
            x_monitor[1] <= x;
            if (state == STATE_E || state == STATE_F) begin
                y_monitor <= {y_monitor[0], y};
            end else begin
                y_monitor <= 0;
            end
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            STATE_A: begin
                if (~resetn) next_state = STATE_A;
                else next_state = STATE_B;
            end

            STATE_B: begin
                next_state = STATE_C;
            end

            STATE_C: begin
                if (x_monitor == 2'b00 && x == 1) next_state = STATE_D;
                else next_state = STATE_C;
            end

            STATE_D: begin
                if (x_monitor == 2'b01 && x == 0) next_state = STATE_E;
                else next_state = STATE_D;
            end

            STATE_E: begin
                if (x_monitor == 2'b10 && x == 1) begin
                    next_state = STATE_F;
                end else next_state = STATE_E;
            end

            STATE_F: begin
                if (y_monitor[0]) next_state = STATE_G;
                else if (y_monitor == 2'b00 || y_monitor == 2'b01) next_state = STATE_G;
                else next_state = STATE_F;
            end

            STATE_G: begin
                if (~resetn) next_state = STATE_A;
                else next_state = STATE_G;
            end

            default: next_state = STATE_A;
        endcase
    end
endmodule
