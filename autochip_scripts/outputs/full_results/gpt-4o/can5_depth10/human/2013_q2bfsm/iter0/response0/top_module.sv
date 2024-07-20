module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum logic [2:0] {
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

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            y_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                f <= 1'b1;
            end else if (current_state == STATE_C) begin
                f <= 1'b0;
            end

            if (current_state == STATE_D && next_state == STATE_E) begin
                g <= 1'b1;
            end

            if (current_state == STATE_E) begin
                if (y) begin
                    g <= 1'b1; // Maintain g = 1 permanently if y becomes 1 within 2 cycles
                end else if (y_counter == 2'b01) begin
                    g <= 1'b0; // Set g = 0 permanently if y does not become 1 within 2 cycles
                end
            end

            if (current_state == STATE_F) begin
                y_counter <= y_counter + 1;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            STATE_A: begin
                if (resetn) begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
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
                next_state = STATE_G;
            end
            STATE_G: begin
                if (y) begin
                    next_state = STATE_G; // Maintain g = 1 permanently
                end else if (y_counter == 2'b01) begin
                    next_state = STATE_A; // Return to state A if y does not become 1 within 2 cycles
                end else begin
                    next_state = STATE_F; // Stay in STATE_F to continue checking y
                end
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule
