module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
    typedef enum {STATE_A, STATE_B, STATE_C, STATE_D, STATE_E, STATE_F} state_t;
    state_t state, next_state;

    reg [1:0] x_sequence;
    reg [1:0] y_counter;

    // Output and state transition logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
            x_sequence <= 0;
            y_counter <= 0;
            f <= 0;
            g <= 0;
        end else begin
            state <= next_state;
            case (state)
                STATE_A: begin
                    f <= 0;
                    g <= 0;
                end
                STATE_B: begin
                    f <= 1;
                    g <= 0;
                end
                STATE_C: begin
                    f <= 0;
                    x_sequence <= {x_sequence[0], x};
                end
                STATE_D, STATE_E, STATE_F: begin
                    f <= 0;
                    y_counter <= y_counter + 1;
                end
            endcase
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_A: next_state = resetn ? STATE_B : STATE_A;
            STATE_B: next_state = STATE_C; // Set f = 1 for one cycle
            STATE_C: begin
                if (x_sequence == 2'b10 && x == 1) // Monitoring for "101"
                    next_state = STATE_D;
                else
                    next_state = STATE_C;
            end
            STATE_D: begin
                if (y == 1) // y = 1 within first cycle
                    next_state = STATE_F;
                else
                    next_state = STATE_E;
            end
            STATE_E: begin
                if (y == 1) // y = 1 within second cycle
                    next_state = STATE_F;
                else
                    next_state = STATE_F;
            end
            STATE_F: next_state = STATE_F; // Final state, maintain outputs
        endcase
    end

    // Output logic for g
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            g <= 0;
        end else begin
            if (state == STATE_D || state == STATE_E) begin
                g <= 1;
            end else if ((state == STATE_E && y_counter == 2'b10 && y != 1) || (state == STATE_F && y_counter == 2'b10)) begin
                g <= 0;
            end
        end
    end

endmodule
