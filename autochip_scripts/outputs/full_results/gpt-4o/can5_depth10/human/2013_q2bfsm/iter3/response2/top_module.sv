module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum logic [2:0] {
        STATE_A = 3'b000,  // Reset state
        STATE_B = 3'b001,  // Set f = 1 for one clock cycle
        STATE_C = 3'b010,  // Observe x for 1
        STATE_D = 3'b011,  // Observe x for 0
        STATE_E = 3'b100,  // Observe x for 1
        STATE_F = 3'b101,  // Output g = 1, observe y
        STATE_G = 3'b110,  // Maintain g = 1 permanently
        STATE_H = 3'b111   // Maintain g = 0 permanently
    } state_t;

    state_t current_state, next_state;
    logic [1:0] y_counter;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            y_counter <= 2'b00;
            f <= 1'b0;
            g <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_F && y != 1'b1) begin
                y_counter <= y_counter + 1;
            end else if (current_state != STATE_F) begin
                y_counter <= 2'b00;
            end
        end
    end

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f <= 1'b0;
            g <= 1'b0;
        end else begin
            case (current_state)
                STATE_A: begin
                    f <= 1'b0;
                    g <= 1'b0;
                end
                STATE_B: begin
                    f <= 1'b1;
                    g <= 1'b0;
                end
                STATE_C,
                STATE_D,
                STATE_E: begin
                    f <= 1'b0;
                    g <= 1'b0;
                end
                STATE_F: begin
                    f <= 1'b0;
                    g <= 1'b1;
                end
                STATE_G: begin
                    f <= 1'b0;
                    g <= 1'b1;
                end
                STATE_H: begin
                    f <= 1'b0;
                    g <= 1'b0;
                end
                default: begin
                    f <= 1'b0;
                    g <= 1'b0;
                end
            endcase
        end
    end

    always @(*) begin
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
                if (x == 1'b1) begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                if (x == 1'b0) begin
                    next_state = STATE_E;
                end
            end
            STATE_E: begin
                if (x == 1'b1) begin
                    next_state = STATE_F;
                end
            end
            STATE_F: begin
                if (y == 1'b1) begin
                    next_state = STATE_G;
                end else if (y_counter == 2'b10) begin
                    next_state = STATE_H;
                end
            end
            STATE_G: begin
                // Stay in State G
            end
            STATE_H: begin
                // Stay in State H
            end
            default: next_state = STATE_A;
        endcase
    end

endmodule
