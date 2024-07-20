module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // Define states
    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;

    state_t current_state, next_state;

    reg [1:0] x_history;
    reg [1:0] y_count;

    // State transition logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Next state logic and output logic
    always @(current_state, x, y) begin
        // Default values
        next_state = current_state;
        f = 0;
        g = 0;
        case (current_state)
            STATE_A: begin
                // Stay in STATE_A until reset is lifted
                if (resetn) begin
                    next_state = STATE_B;
                    f = 1;
                end
            end
            STATE_B: begin
                // Monitor x for the sequence 1, 0, 1
                // Shift in the new x value into x_history
                x_history = {x_history[0], x};
                if (x_history == 2'b10 && x == 1'b1) begin
                    next_state = STATE_C;
                end
            end
            STATE_C: begin
                g = 1;
                next_state = STATE_D;
            end
            STATE_D: begin
                g = 1;
                if (y == 1'b1) begin
                    next_state = STATE_F;
                end else if (y_count == 2'b10) begin
                    next_state = STATE_E;
                end else begin
                    next_state = STATE_D;
                end
            end
            STATE_E: begin
                g = 0;
            end
            STATE_F: begin
                g = 1;
            end
        endcase
    end

    // y counter logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            y_count <= 2'b00;
        else if (current_state == STATE_D && y == 1'b0)
            y_count <= y_count + 1;
    end

    // x history logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            x_history <= 2'b00;
        else if (current_state == STATE_B)
            x_history <= {x_history[0], x};
    end

endmodule
