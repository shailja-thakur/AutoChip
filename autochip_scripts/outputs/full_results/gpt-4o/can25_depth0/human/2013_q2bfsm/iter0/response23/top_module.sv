module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State Definitions
    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101,
        STATE_G = 3'b110
    } state_t;

    state_t state, next_state;
    reg [1:0] y_count;

    // State Transitions
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end

    // Next State Logic
    always_comb begin
        next_state = state; // Default to stay in same state
        f = 1'b0; // Default output
        g = 1'b0; // Default output

        case (state)
            STATE_A: begin
                if (resetn == 1'b1) begin
                    f = 1'b1;
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                if (x == 1'b1) next_state = STATE_C;
            end
            STATE_C: begin
                if (x == 1'b0) next_state = STATE_D;
            end
            STATE_D: begin
                if (x == 1'b1) next_state = STATE_E;
            end
            STATE_E: begin
                g = 1'b1;
                if (y == 1'b1) begin
                    next_state = STATE_F;
                end else if (y_count == 2'b10) begin
                    next_state = STATE_G;
                end
            end
            STATE_F: begin
                g = 1'b1;
            end
            STATE_G: begin
                g = 1'b0;
            end
        endcase
    end

    // Count the y input clock cycles
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            y_count <= 2'b00;
        end else if (state == STATE_E) begin
            y_count <= y_count + 1;
        end else begin
            y_count <= 2'b00;
        end
    end

endmodule
