module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    typedef enum logic [2:0] {
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100
    } state_t;
    
    state_t state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= S0;
            start_shifting <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state; // Default is to stay in the same state
        case (state)
            S0: if (data) next_state = S1;
            S1: if (data) next_state = S2; else next_state = S0;
            S2: if (!data) next_state = S3; // Only if 110 appears first
            S3: if (data) next_state = S4; else next_state = S0;
            S4: next_state = S4;
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            start_shifting <= 1'b0;
        end else begin
            if (state == S4) 
                start_shifting <= 1'b1;
        end
    end

endmodule
