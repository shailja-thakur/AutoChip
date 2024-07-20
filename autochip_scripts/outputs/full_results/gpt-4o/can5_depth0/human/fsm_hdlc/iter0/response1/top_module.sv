module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum logic [2:0] {
        S0, S1, S11, S111, S1111, S11111, S111110, S111111
    } state_t;
    
    state_t state, next_state;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        // Default outputs
        disc = 0;
        flag = 0;
        err = 0;

        case (state)
            S0: begin
                if (in) next_state = S1;
                else next_state = S0;
            end
            S1: begin
                if (in) next_state = S11;
                else next_state = S0;
            end
            S11: begin
                if (in) next_state = S111;
                else next_state = S0;
            end
            S111: begin
                if (in) next_state = S1111;
                else next_state = S0;
            end
            S1111: begin
                if (in) next_state = S11111;
                else next_state = S0;
            end
            S11111: begin
                if (in) next_state = S111110;
                else next_state = S0;
            end
            S111110: begin
                if (in) begin
                    next_state = S111111;
                    flag = 1;
                end else begin
                    next_state = S0;
                    disc = 1;
                end
            end
            S111111: begin
                if (in) begin
                    next_state = S111111;
                    err = 1;
                end else begin
                    next_state = S0;
                end
            end
            default: next_state = S0;
        endcase
    end
endmodule
