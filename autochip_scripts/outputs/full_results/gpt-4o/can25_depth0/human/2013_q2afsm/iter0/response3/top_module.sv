module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
    } state_t;

    state_t current_state, next_state;

    // State flip-flops
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (r[1])
                    next_state = STATE_B;
                else if (r[2])
                    next_state = STATE_C;
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
            default: next_state = STATE_A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_A: g = 3'b000; // No grants
            STATE_B: g = 3'b001; // Grant to device 1
            STATE_C: g = 3'b010; // Grant to device 2
            default: g = 3'b000;
        endcase
    end

endmodule
