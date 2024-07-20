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
        STATE_F = 3'b101,
        STATE_G = 3'b110
    } state_t;

    state_t state, next_state;

    reg [1:0] x_counter;
    reg [1:0] y_counter;

    always @ (posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    always @ (*) begin
        next_state = state;
        f = 0;
        g = 0;

        case (state)
            STATE_A: begin
                if (!resetn)
                    next_state = STATE_B;
            end

            STATE_B: begin
                if (resetn) begin
                    f = 1;
                    next_state = STATE_C;
                end
            end

            STATE_C: begin
                if (x == 1'b1 && x_counter == 2'b00) begin
                    next_state = STATE_D;
                    x_counter = x_counter + 1;
                end
                else if (x == 1'b0 && x_counter == 2'b01) begin
                    next_state = STATE_E;
                    x_counter = x_counter + 1;
                end
                else if (x == 1'b1 && x_counter == 2'b10) begin
                    next_state = STATE_F;
                    x_counter = 0;
                end
                else
                    next_state = STATE_C;
            end

            STATE_D: begin
                if (x == 1'b0) begin
                    next_state = STATE_E;
                    x_counter = 2'b01;
                end
                else
                    next_state = STATE_A;
            end

            STATE_E: begin
                if (x == 1'b1) begin
                    next_state = STATE_F;
                    x_counter = 2'b10;
                end
                else
                    next_state = STATE_A;
            end

            STATE_F: begin
                g = 1;
                y_counter = 0;
                next_state = STATE_G;
            end

            STATE_G: begin
                g = 1;
                if (y == 1'b1) begin
                    g = 1;
                end
                else if (y_counter == 2'b01) begin
                    g = 0;
                end
                else begin
                    y_counter = y_counter + 1;
                end
            end

            default: next_state = STATE_A;
        endcase
    end

endmodule
