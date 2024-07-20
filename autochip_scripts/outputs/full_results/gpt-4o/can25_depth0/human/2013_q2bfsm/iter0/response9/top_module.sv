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
        STATE_F = 3'b001,
        STATE_X1 = 3'b010,
        STATE_X0 = 3'b011,
        STATE_X1_AGAIN = 3'b100,
        STATE_G = 3'b101,
        STATE_WAIT_Y1 = 3'b110,
        STATE_WAIT_Y2 = 3'b111
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            STATE_A: begin
                f = 1'b0;
                g = 1'b0;
                if (!resetn)
                    next_state = STATE_A;
                else
                    next_state = STATE_F;
            end

            STATE_F: begin
                f = 1'b1;
                g = 1'b0;
                next_state = STATE_X1;
            end
            
            STATE_X1: begin
                f = 1'b0;
                g = 1'b0;
                if (x == 1'b1)
                    next_state = STATE_X0;
                else
                    next_state = STATE_X1;
            end

            STATE_X0: begin
                f = 1'b0;
                g = 1'b0;
                if (x == 1'b0)
                    next_state = STATE_X1_AGAIN;
                else
                    next_state = STATE_X1;
            end

            STATE_X1_AGAIN: begin
                f = 1'b0;
                g = 1'b0;
                if (x == 1'b1)
                    next_state = STATE_G;
                else
                    next_state = STATE_X1;
            end

            STATE_G: begin
                f = 1'b0;
                g = 1'b1;
                next_state = STATE_WAIT_Y1;
            end

            STATE_WAIT_Y1: begin
                f = 1'b0;
                g = 1'b1;
                if (y == 1'b1)
                    next_state = STATE_G;
                else
                    next_state = STATE_WAIT_Y2;
            end

            STATE_WAIT_Y2: begin
                f = 1'b0;
                g = 1'b1;
                if (y == 1'b1)
                    next_state = STATE_G;
                else
                    next_state = STATE_A;
            end

            default: begin
                f = 1'b0;
                g = 1'b0;
                next_state = STATE_A;
            end
        endcase
    end
endmodule
