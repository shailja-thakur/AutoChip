module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum logic [2:0] {
        STATE_A = 3'd0,
        STATE_B = 3'd1,
        STATE_C = 3'd2,
        STATE_D = 3'd3,
        STATE_E = 3'd4,
        STATE_F = 3'd5
    } state_t;

    state_t state, next_state;
    logic [2:0] x_history;
    logic [1:0] y_counter;

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
            f <= 0;
            g <= 0;
        end else begin
            state <= next_state;
        end
    end

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            x_history <= 3'b000;
        end else if (state == STATE_B || state == STATE_C || state == STATE_D) begin
            x_history <= {x_history[1:0], x};
        end
    end

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            y_counter <= 2'b00;
        end else if (state == STATE_E && !g) begin
            y_counter <= y_counter + 1;
        end else if (state != STATE_E) begin
            y_counter <= 2'b00;
        end
    end

    always_comb begin
        next_state = state;
        f = 0;
        g = 0;

        case (state)
            STATE_A: begin
                if (resetn) begin
                    next_state = STATE_B;
                end
            end

            STATE_B: begin
                f = 1;
                next_state = STATE_C;
            end

            STATE_C: begin
                if (x_history == 3'b101) begin
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_C;
                end
            end

            STATE_D: begin
                g = 1;
                next_state = STATE_E;
            end

            STATE_E: begin
                if (y == 1) begin
                    g = 1;
                    next_state = STATE_F;
                end else if (y_counter == 2'b10) begin
                    g = 0;
                    next_state = STATE_F;
                end else begin
                    g = 1;
                end
            end
            
            STATE_F: begin
                g = (y_counter != 2'b10);
            end

            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule
