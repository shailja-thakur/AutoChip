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
    reg [1:0] y_counter;
    reg [1:0] x_counter;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
            f <= 0;
            g <= 0;
            y_counter <= 0;
            x_counter <= 0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            STATE_A: begin
                f = 0;
                g = 0;
                if (resetn) next_state = STATE_B;
            end

            STATE_B: begin
                f = 1;
                next_state = STATE_C;
            end

            STATE_C: begin
                f = 0;
                if (x) begin
                    x_counter = {x_counter[0], 1'b1};
                    if (x_counter == 2'b01) next_state = STATE_D;
                end else begin
                    x_counter = 2'b00;
                end
            end

            STATE_D: begin
                if (!x) next_state = STATE_C;
                else begin
                    next_state = STATE_E;
                end
            end

            STATE_E: begin
                if (x) begin
                    g = 1;
                    next_state = STATE_F;
                end else begin
                    next_state = STATE_C;
                end
            end

            STATE_F: begin
                f = 0;
                if (y) begin
                    y_counter = 2'b00;
                    next_state = STATE_G;
                end else begin
                    if (y_counter < 2) y_counter = y_counter + 1;
                    else begin
                        g = 0;
                        next_state = STATE_A;
                    end
                end
            end

            STATE_G: begin
                f = 0;
                g = 1;
            end

            default: begin
                next_state = STATE_A;
            end
        endcase
    end
endmodule
