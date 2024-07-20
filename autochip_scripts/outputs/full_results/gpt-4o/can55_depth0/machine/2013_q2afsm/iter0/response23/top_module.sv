module top_module(
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State definition
    typedef enum reg [1:0] {STATE_A, STATE_B, STATE_C, STATE_D} state_t;
    state_t state, next_state;

    // State register update
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_A: begin
                if (r[1])
                    next_state = STATE_B;
                else if (r[2])
                    next_state = STATE_C;
                else if (r[3])
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (r[1])
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_C: begin
                if (r[2])
                    next_state = STATE_C;
                else
                    next_state = STATE_A;
            end
            STATE_D: begin
                if (r[3])
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
            end
        endcase
    end

    // Output logic
    always @(*) begin
        g = 3'b000; // default value
        case (state)
            STATE_B: g[1] = 1'b1;
            STATE_C: g[2] = 1'b1;
            STATE_D: g[3] = 1'b1;
            default: g = 3'b000;
        endcase
    end

endmodule
