module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    typedef enum logic [2:0] {
        S0, // Initial state
        S1, // Got '1'
        S2, // Got '11'
        S3, // Got '110'
        S4  // Got '1101'
    } state_t;

    state_t state, next_state;

    // State transition logic (combinational)
    always_comb begin
        case (state)
            S0:  begin
                if (data == 1) 
                    next_state = S1;
                else 
                    next_state = S0;
            end

            S1: begin
                if (data == 1) 
                    next_state = S2;
                else 
                    next_state = S0;
            end

            S2: begin
                if (data == 0) 
                    next_state = S3;
                else 
                    next_state = S2;
            end

            S3: begin
                if (data == 1) 
                    next_state = S4;
                else 
                    next_state = S0;
            end

            S4: begin
                next_state = S4;
            end

            default: next_state = S0;
        endcase
    end

    // State flip-flops (sequential)
    always_ff @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Output logic (combinational)
    always_comb begin
        if (state == S4)
            start_shifting = 1;
        else
            start_shifting = 0;
    end

endmodule
