module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        next_state = state; // Default is to stay in the same state
        case (state)
            STATE_A: begin
                if (resetn)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x) 
                    next_state = STATE_D;
                else 
                    next_state = STATE_C;
            end
            STATE_D: begin
                if (!x)
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
                if (y)
                    next_state = STATE_F;
                else if (!y)
                    next_state = STATE_A;
            end
            default: next_state = STATE_A;
        endcase
    end

    // State flip-flops
    always @(posedge clk) begin
        if (~resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (~resetn) begin
            f <= 1'b0;
            g <= 1'b0;
        end
        else begin
            case (state)
                STATE_B: f <= 1'b1;
                STATE_F: g <= 1'b1;
                STATE_A: g <= 1'b0;
                default: f <= 1'b0;
            endcase
        end
    end
endmodule
