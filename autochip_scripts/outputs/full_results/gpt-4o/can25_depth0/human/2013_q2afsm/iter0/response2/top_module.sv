module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State Encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;
    
    state_t current_state, next_state;

    // State Table (Next State Logic)
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (r[1] == 1)
                    next_state = STATE_B;
                else if (r[2] == 1)
                    next_state = STATE_C;
                else 
                    next_state = STATE_A;
            end

            STATE_B: begin
                if (r[1] == 1)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end

            STATE_C: begin
                if (r[2] == 1)
                    next_state = STATE_C;
                else
                    next_state = STATE_A;
            end

            default: next_state = STATE_A; // Default to reset state
        endcase
    end

    // State Flip-Flops (Sequential Logic)
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Output Logic
    always @(*) begin
        case (current_state)
            STATE_A: g = 3'b000;
            STATE_B: g = 3'b001; // g1 = 1, g2 = 0, g3 = 0
            STATE_C: g = 3'b010; // g1 = 0, g2 = 1, g3 = 0
            default: g = 3'b000; // Default to no grants
        endcase
    end
endmodule
