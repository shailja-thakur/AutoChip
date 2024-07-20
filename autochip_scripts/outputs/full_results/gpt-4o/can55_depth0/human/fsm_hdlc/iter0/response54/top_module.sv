module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State encoding
    typedef enum logic [2:0] {
        S0,
        S1,
        S2,
        S3,
        S4,
        S5,
        S6,
        S7
    } state_t;

    state_t state, next_state;

    // Sequential state transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Combinational state transition logic
    always_comb begin
        next_state = state; // default stay in current state
        disc = 0;
        flag = 0;
        err = 0;
        
        case (state)
            S0: begin
                if (in) begin
                    next_state = S1;
                end
            end
            S1: begin
                if (in) begin
                    next_state = S2;
                end else begin
                    next_state = S0;
                end
            end
            S2: begin
                if (in) begin
                    next_state = S3;
                end else begin
                    next_state = S0;
                end
            end
            S3: begin
                if (in) begin
                    next_state = S4;
                end else begin
                    next_state = S0;
                end
            end
            S4: begin
                if (in) begin
                    next_state = S5;
                end else begin
                    next_state = S0;
                end
            end
            S5: begin
                if (in) begin
                    next_state = S6;
                end else begin
                    next_state = S0;
                end
            end
            S6: begin
                if (in) begin
                    next_state = S7;
                end else begin
                    next_state = S0;
                    disc = 1;
                end
            end
            S7: begin
                if (in) begin
                    next_state = S7; // remain in error state if more 1s are received
                    err = 1;
                end else begin
                    next_state = S0;
                    flag = 1;
                end
            end
        endcase
    end
endmodule
