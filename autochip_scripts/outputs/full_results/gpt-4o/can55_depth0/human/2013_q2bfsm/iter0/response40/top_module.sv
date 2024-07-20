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

    state_t current_state, next_state;
    reg [1:0] y_counter;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state;
        f = 0;
        g = 0;

        case(current_state)
            STATE_A: begin
                f = 0;
                g = 0;
                if (resetn) 
                    next_state = STATE_B;
            end

            STATE_B: begin
                f = 1;
                g = 0;
                next_state = STATE_C;
            end

            STATE_C: begin
                f = 0;
                g = 0;
                if (x) begin
                    next_state = STATE_D;
                end
            end

            STATE_D: begin
                if (!x) begin
                    next_state = STATE_E;
                end
            end

            STATE_E: begin
                if (x) begin
                    next_state = STATE_F;
                end
            end

            STATE_F: begin
                g = 1;
                y_counter = 2'b00;
                next_state = STATE_G;
            end

            STATE_G: begin
                g = 1;
                if (y) begin
                    next_state = STATE_G;
                end else begin
                    if (y_counter < 2'b10) begin
                        y_counter = y_counter + 1;
                    end else begin
                        next_state = STATE_A;
                    end
                end
            end

            default: next_state = STATE_A;
        endcase
    end
endmodule
