module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum reg [2:0] {
        STATE_A   = 3'b000,
        STATE_B   = 3'b001,
        STATE_C   = 3'b010,
        STATE_D   = 3'b011,
        STATE_E   = 3'b100,
        STATE_F   = 3'b101
    } state_t;
    
    state_t current_state, next_state;
    reg [1:0] y_counter;
    
    always @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 0;
            g <= 0;
            y_counter <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B)
                f <= 1;
            else if (current_state == STATE_C && next_state != STATE_C)
                f <= 0;
            if (current_state == STATE_E && (next_state == STATE_E || y == 1))
                g <= 1;
            else if (current_state == STATE_F)
                g <= 0;
            if (current_state == STATE_D && y != 1)
                y_counter <= y_counter + 1;
            else
                y_counter <= 0;
        end
    end
    
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (!resetn)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x == 1)
                    next_state = STATE_D;
                else
                    next_state = STATE_C;
            end
            STATE_D: begin
                if (x == 0)
                    next_state = STATE_E;
                else
                    next_state = STATE_C;
            end
            STATE_E: begin
                if (x == 1)
                    next_state = (y == 1) ? STATE_E : (y_counter == 2) ? STATE_F : STATE_E;
                else
                    next_state = STATE_C;
            end
            STATE_F: begin
                next_state = STATE_F;
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule
