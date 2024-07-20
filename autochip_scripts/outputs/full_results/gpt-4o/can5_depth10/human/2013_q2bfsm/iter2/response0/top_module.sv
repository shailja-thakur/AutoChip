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
    logic [1:0] y_counter;
    logic [1:0] x_counter;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            y_counter <= 2'b00;
            x_counter <= 2'b00;
            f <= 1'b0;
            g <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                f <= 1'b1;
            end else begin
                f <= 1'b0;
            end
            if (current_state == STATE_G) begin
                g <= 1'b1;
            end else if (current_state == STATE_F && y_counter == 2'b10 && y != 1) begin
                g <= 1'b0;
            end
            if (current_state == STATE_E || current_state == STATE_F) begin
                if (x == 1'b1) begin
                    x_counter <= x_counter + 1;
                end else if (x_counter != 2'b00) begin
                    x_counter <= 2'b00;
                end
            end else begin
                x_counter <= 2'b00;
            end
            if (current_state == STATE_F && y != 1) begin
                y_counter <= y_counter + 1;
            end else if (current_state != STATE_F) begin
                y_counter <= 2'b00;
            end
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
                end else begin
                    next_state = STATE_C;
                end
            end
            STATE_E: begin
                if (x == 1'b1) begin
                    next_state = STATE_F;
                end else begin
                    next_state = STATE_C;
                end
            end
            STATE_F: begin
                if (y == 1'b1) begin
                    next_state = STATE_G;
                end else if (y_counter == 2'b10) begin
                    next_state = STATE_A;
                end
            end
            STATE_G: begin
                // Maintain g = 1 state
            end
        endcase
    end

endmodule
