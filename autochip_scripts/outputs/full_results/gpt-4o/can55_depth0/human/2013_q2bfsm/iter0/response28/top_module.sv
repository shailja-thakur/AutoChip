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
        STATE_A = 3'd0,
        STATE_B = 3'd1,
        STATE_C = 3'd2,
        STATE_D = 3'd3,
        STATE_E = 3'd4,
        STATE_F = 3'd5,
        STATE_G = 3'd6
    } state_t;

    state_t state, next_state;
    reg [1:0] count; // Counter to monitor y input within two cycles

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (!resetn) begin
            state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
        end else begin
            state <= next_state;

            // Handle f and g assignments
            if (state == STATE_B)
                f <= 1'b1;
            else
                f <= 1'b0;

            if (state == STATE_E || state == STATE_F)
                g <= 1'b1;
            else if (state == STATE_G)
                g <= 1'b0;
        end
    end

    // Next state logic
    always @* begin
        next_state = state; // Default state transitions

        case (state)
            STATE_A: begin
                if (!resetn)
                    next_state = STATE_B;
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x == 1'b1)
                    next_state = STATE_D;
            end
            STATE_D: begin
                if (x == 1'b0)
                    next_state = STATE_E;
            end
            STATE_E: begin
                if (x == 1'b1)
                    next_state = STATE_F;
            end
            STATE_F: begin
                if (y == 1'b1)
                    next_state = STATE_F; // Stay in this state if y becomes 1
                else if (count == 2)
                    next_state = STATE_G; // Move to STATE_G after 2 cycles if y is not 1
                else
                    next_state = STATE_F; // Continue checking y
            end
            STATE_G: begin
                next_state = STATE_G; // Remain in STATE_G permanently
            end
        endcase
    end

    // Counting y input cycles
    always @(posedge clk) begin
        if (state == STATE_F && y != 1'b1)
            count <= count + 1;
        else if (state != STATE_F)
            count <= 2'd0;
    end

endmodule
