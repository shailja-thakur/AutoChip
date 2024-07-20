module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // Define state encoding
    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;

    state_t current_state, next_state;

    // Tracking x and y sequences
    reg [1:0] x_sequence;
    reg [1:0] y_counter;

    always @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            x_sequence <= 2'b00;
            y_counter <= 2'b00;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        // Default values
        next_state = current_state;
        f = 0;
        g = 0;

        case (current_state)
            STATE_A: begin
                if (!resetn) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end

            STATE_B: begin
                f = 1;
                next_state = STATE_C;
            end

            STATE_C: begin
                if (x_sequence == 2'b01 && x == 1) begin
                    next_state = STATE_D;
                end else if (x_sequence == 2'b01) begin
                    next_state = STATE_C;
                end else if (x_sequence == 2'b00 && x == 1) begin
                    x_sequence = 2'b01;
                    next_state = STATE_C;
                end else if (x_sequence == 2'b01 && x == 0) begin
                    x_sequence = 2'b10;
                    next_state = STATE_C;
                end else if (x_sequence == 2'b10 && x == 1) begin
                    next_state = STATE_D;
                end
            end

            STATE_D: begin
                g = 1;
                if (y == 1) begin
                    next_state = STATE_F;
                end else begin
                    y_counter = y_counter + 1;
                    if (y_counter == 2) begin
                        next_state = STATE_E;
                    end else begin
                        next_state = STATE_D;
                    end
                end
            end

            STATE_E: begin
                g = 0;
            end

            STATE_F: begin
                g = 1;
            end

            default: begin
                next_state = STATE_A;
            end
        endcase
    end
endmodule
