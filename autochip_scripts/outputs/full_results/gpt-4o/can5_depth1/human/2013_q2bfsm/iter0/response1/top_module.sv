module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;

    state_t state, next_state;
    logic [2:0] x_history;
    logic [1:0] y_counter;

    // State transition
    always_ff @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= STATE_A;
            x_history <= 3'b000;
            y_counter <= 2'b00;
            f <= 1'b0;
            g <= 1'b0;
        end else begin
            state <= next_state;
            if (state >= STATE_C && state <= STATE_D)
                x_history <= {x_history[1:0], x};
            if (state == STATE_E || state == STATE_F)
                y_counter <= y_counter + 1;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        f = 1'b0;
        g = (state == STATE_E) ? 1'b1 : g;
        
        unique case (state)
            STATE_A: begin
                if (resetn) 
                    next_state = STATE_B;
            end
            STATE_B: begin
                f = 1'b1;
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x_history == 3'b101)
                    next_state = STATE_D;
            end
            STATE_D: begin
                if (x_history == 3'b101)
                    next_state = STATE_E;
            end
            STATE_E: begin
                if (y == 1'b1)
                    next_state = STATE_F;
                else if (y_counter == 2'b10)
                    g = 1'b0;
            end
            STATE_F: begin
                // Stay in STATE_F forever, maintaining g = 1
            end
            default: next_state = STATE_A;
        endcase
    end

endmodule
