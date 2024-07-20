module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State declarations
    typedef enum reg [3:0] {
        STATE_A = 4'd0,
        STATE_B = 4'd1,
        STATE_C = 4'd2,
        STATE_D = 4'd3,
        STATE_E = 4'd4,
        STATE_F = 4'd5,
        STATE_G = 4'd6,
        STATE_H = 4'd7
    } state_t;

    reg [3:0] state, next_state;
    reg [1:0] y_counter;

    // Combinational logic for next state and outputs
    always @(*) begin
        // Default output values
        next_state = state;
        f = 0;
        g = 0;

        case (state)
            STATE_A: begin
                if (~resetn)
                    next_state = STATE_B;
            end

            STATE_B: begin
                f = 1;
                next_state = STATE_C;
            end

            STATE_C: begin
                if (x)
                    next_state = STATE_D;
                else
                    next_state = STATE_C;
            end

            STATE_D: begin
                if (~x)
                    next_state = STATE_E;
                else
                    next_state = STATE_C;
            end

            STATE_E: begin
                if (x)
                    next_state = STATE_F;
                else
                    next_state = STATE_C;
            end

            STATE_F: begin
                g = 1;
                next_state = STATE_G;
            end

            STATE_G: begin
                g = 1;
                if (y) begin
                    y_counter = 2'd0;
                    next_state = STATE_H;
                end else if (y_counter == 2'd2) begin
                    g = 0;
                    next_state = STATE_A;
                end
            end

            STATE_H: begin
                g = 1;
                if (y) 
                    y_counter = 2'd0;
                else 
                    y_counter = y_counter + 1;
            end

            default: 
                next_state = STATE_A;
        endcase
    end

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (~resetn) begin
            state <= STATE_A;
            y_counter <= 2'd0;
        end else begin
            state <= next_state;
        end
    end
endmodule
