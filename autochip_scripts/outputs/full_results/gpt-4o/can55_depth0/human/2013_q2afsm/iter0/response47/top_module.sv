module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State declaration
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    // State registers
    reg [1:0] state, next_state;

    // State transition logic (state table)
    always @(*) begin
        case (state)
            STATE_A:
                if (r[1])
                    next_state = STATE_B;
                else if (r[2])
                    next_state = STATE_C;
                else if (r[3])
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            STATE_B:
                if (r[1])
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            STATE_C:
                if (r[2])
                    next_state = STATE_C;
                else
                    next_state = STATE_A;
            STATE_D:
                if (r[3])
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            default:
                next_state = STATE_A;
        endcase
    end

    // State flip-flops
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            STATE_A: g = 3'b000;
            STATE_B: g = 3'b001;
            STATE_C: g = 3'b010;
            STATE_D: g = 3'b100;
            default: g = 3'b000;
        endcase
    end

endmodule
