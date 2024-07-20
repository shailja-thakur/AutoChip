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
        STATE_G,
        STATE_H
    } state_t;
    
    state_t current_state, next_state;
    reg [1:0] y_counter;
    reg [2:0] x_pattern; // To monitor the 3 clock cycles of x

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            y_counter <= 2'b00;
            x_pattern <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_C || current_state == STATE_D) begin
                x_pattern <= {x_pattern[1:0], x};
            end
            
            if (current_state == STATE_F || current_state == STATE_G) begin
                y_counter <= y_counter + 1;
            end
            
            if (current_state != STATE_F && current_state != STATE_G) begin
                y_counter <= 2'b00;
            end
            
            if (current_state != STATE_C && current_state != STATE_D) begin
                x_pattern <= 3'b000;
            end
        end
    end

    always @(*) begin
        case (current_state)
            STATE_A: begin
                f = 0;
                g = 0;
                if (!resetn) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end

            STATE_B: begin
                f = 1;
                g = 0;
                next_state = STATE_C;
            end

            STATE_C: begin
                f = 0;
                g = 0;
                if (x_pattern == 3'b101) begin
                    next_state = STATE_E;
                end else begin
                    next_state = STATE_D;
                end
            end

            STATE_D: begin
                f = 0;
                g = 0;
                if (x_pattern == 3'b101) begin
                    next_state = STATE_E;
                end else begin
                    next_state = STATE_C;
                end
            end

            STATE_E: begin
                f = 0;
                g = 1;
                next_state = STATE_F;
            end

            STATE_F: begin
                f = 0;
                g = 1;
                if (y) begin
                    next_state = STATE_H;
                end else if (y_counter == 2'b10) begin
                    next_state = STATE_G;
                end else begin
                    next_state = STATE_F;
                end
            end

            STATE_G: begin
                f = 0;
                g = 0;
                next_state = STATE_G;
            end

            STATE_H: begin
                f = 0;
                g = 1;
                next_state = STATE_H;
            end

            default: begin
                f = 0;
                g = 0;
                next_state = STATE_A;
            end
        endcase
    end
endmodule
