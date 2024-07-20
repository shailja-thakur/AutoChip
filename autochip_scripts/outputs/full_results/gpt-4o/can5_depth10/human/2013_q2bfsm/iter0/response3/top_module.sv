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
        STATE_A = 3'd0,
        STATE_B = 3'd1,
        STATE_C = 3'd2,
        STATE_D = 3'd3,
        STATE_E = 3'd4,
        STATE_F = 3'd5
    } state_t;

    // State, next state, and input tracking
    state_t state, next_state;
    logic [2:0] x_seq_count;
    logic [1:0] y_delay_count;

    // State transition logic
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
            x_seq_count <= 3'd0;
            y_delay_count <= 2'd0;
        end else begin
            state <= next_state;
            
            // Reset counters if not needed
            if (state == STATE_B || state == STATE_C || state == STATE_D) begin
                if (x == 1'b1) begin
                    x_seq_count <= 3'd1;
                end else begin
                    x_seq_count <= 3'd0;
                end
            end else if (state == STATE_E) begin
                y_delay_count <= 2'd0;
            end
        end
    end

    // Next state logic and output generation
    always_comb begin
        next_state = state;
        f = 1'b0;
        g = (state == STATE_E || state == STATE_F); // Maintain g = 1 if in STATE_E or STATE_F

        case (state)
            STATE_A: begin
                if (!resetn) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                    f = 1'b1; // Set f to 1 for one clock cycle
                end
            end
            
            STATE_B: begin
                if (x == 1'b1) begin
                    next_state = STATE_C;
                    x_seq_count = 3'd1;
                end
            end

            STATE_C: begin
                if (x_seq_count == 3'd1 && x == 1'b0) begin
                    next_state = STATE_D;
                    x_seq_count = 3'd0;
                end else if (x != 1'b1) begin
                    next_state = STATE_B;
                end
            end

            STATE_D: begin
                if (x_seq_count == 3'd0 && x == 1'b1) begin
                    next_state = STATE_E;
                    g = 1'b1; // Set g to 1 on the following clock cycle
                end else if (x != 1'b0) begin
                    next_state = STATE_B;
                end
            end

            STATE_E: begin
                if (y == 1'b1) begin
                    next_state = STATE_F;
                end else if (y_delay_count == 2'd2) begin
                    next_state = STATE_A;
                    g = 1'b0; // Set g = 0 if y does not become 1 within two cycles
                end else begin
                    y_delay_count = y_delay_count + 1;
                end
            end

            STATE_F: begin
                // Stay in STATE_F indefinitely unless reset
                if (!resetn) begin
                    next_state = STATE_A;
                end
            end
            
            default: next_state = STATE_A;

        endcase
    end

endmodule
