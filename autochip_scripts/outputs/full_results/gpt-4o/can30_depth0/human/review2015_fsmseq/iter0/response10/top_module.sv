module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    typedef enum logic [2:0] {
        S0, S1, S2, S3, S4
    } state_t;
    
    state_t state, next_state;
    
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= S0;
            start_shifting <= 0;
        end else begin
            state <= next_state;
        end
    end
    
    always_comb begin
        next_state = state;
        case (state)
            S0: if (data) next_state = S1;
            S1: if (data) next_state = S2; else next_state = S0;
            S2: if (data) next_state = S2; else next_state = S3;
            S3: if (data) next_state = S4; else next_state = S0;
            S4: if (~start_shifting) start_shifting = 1;
        endcase
    end
    
endmodule
