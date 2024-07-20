module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State declarations
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;
    
    state_t current_state, next_state;

    // State flip-flops (sequential logic)
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // State transition logic (combinatorial logic)
    always_comb begin
        next_state = current_state; // Default to stay in current state
        case (current_state)
            STATE_A: begin
                if (r[1])
                    next_state = STATE_B;
                else if (r[2])
                    next_state = STATE_C;
                else if (r[3])
                    next_state = STATE_D;
            end
            STATE_B: begin
                if (!r[1])
                    next_state = STATE_A;
            end
            STATE_C: begin
                if (!r[2])
                    next_state = STATE_A;
            end
            STATE_D: begin
                if (!r[3])
                    next_state = STATE_A;
            end
        endcase
    end

    // Output logic based on current state
    always_comb begin
        g = 3'b000; // Default to no grants
        case (current_state)
            STATE_B: g[1] = 1;
            STATE_C: g[2] = 1;
            STATE_D: g[3] = 1;
            default: g = 3'b000;
        endcase
    end
endmodule
