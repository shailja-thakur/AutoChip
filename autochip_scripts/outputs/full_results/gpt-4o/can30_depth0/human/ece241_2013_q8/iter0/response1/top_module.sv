module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        S1   = 2'b01,
        S2   = 2'b10
    } state_t;
    
    state_t state, next_state;

    // State transition
    always_ff @(negedge aresetn, posedge clk) begin
        if (!aresetn)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        z = 1'b0;
        case (state)
            IDLE: begin
                if (x)
                    next_state = S1;
                else
                    next_state = IDLE;
            end
            S1: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S2;
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b1; // Sequence "101" detected
                end
                else
                    next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
