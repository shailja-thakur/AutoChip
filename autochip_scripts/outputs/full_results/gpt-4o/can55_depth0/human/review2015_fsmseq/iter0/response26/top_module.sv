module top_module (
    input clk,
    input reset,
    input data,
    output reg start_shifting
);
    // State encoding
    typedef enum logic [2:0] {
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100
    } state_t;
    
    state_t state, next_state;

    // Sequential Logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= S0;
            start_shifting <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Combinational Logic
    always_comb begin
        next_state = state; // Default next state
        case (state)
            S0: begin
                if (data)
                    next_state = S1;
            end
            S1: begin
                if (data)
                    next_state = S2;
                else
                    next_state = S0;
            end
            S2: begin
                if (data)
                    next_state = S2;
                else
                    next_state = S3;
            end
            S3: begin
                if (data)
                    next_state = S4;
                else
                    next_state = S0;
            end
            S4: begin
                start_shifting = 1;
                next_state = S4; // Stays in S4 once the sequence is detected
            end
            default: next_state = S0;
        endcase
    end
endmodule
