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
    logic [2:0] sequence; // Used to track the 1, 0, 1 sequences

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            y_counter <= 2'b00;
            f <= 1'b0;
            g <= 1'b0;
            sequence <= 3'b000;
        end else begin
            current_state <= next_state;

            if (current_state == STATE_B) begin
                f <= 1'b1;
            end else begin
                f <= 1'b0;
            end

            if (current_state == STATE_C) begin
                sequence <= {sequence[1:0], x};
            end else begin
                sequence <= 3'b000;
            end

            if (next_state == STATE_F || next_state == STATE_G) begin
                g <= 1'b1;
            end else if (current_state == STATE_F && y_counter == 2'b10 && y != 1) {
                g <= 1'b0;
            end

            if (current_state == STATE_F && y != 1) begin
                y_counter <= y_counter + 1;
            end else if (current_state != STATE_F) {
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
                if (sequence == 3'b101) begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                next_state = STATE_F;
            end
            STATE_F: begin
                if (y == 1) begin
                    next_state = STATE_G;
                end else if (y_counter == 2'b10) {
                    next_state = STATE_A;
                end
            end
            STATE_G: begin
                // Stay in STATE_G
            end
        endcase
    end

endmodule
