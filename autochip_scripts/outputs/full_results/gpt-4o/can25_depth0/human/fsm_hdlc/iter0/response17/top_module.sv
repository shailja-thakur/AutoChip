module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum logic [2:0] {
        S0,   // Initial state / previous input 0
        S1,   // Seen 1
        S11,  // Seen 11
        S111, // Seen 111
        S1111, // Seen 1111
        S11111, // Seen 11111
        S111111, // Seen 111111
        S1111111 // Seen 1111111 or more (error state)
    } state_t;

    state_t state, next_state;
    
    // State transition logic (Moore FSM)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default outputs
        next_state = state;
        disc = 0;
        flag = 0;
        err = 0;

        case (state)
            S0: begin // previous input 0 or initial reset state
                if (in) begin
                    next_state = S1;
                end
            end

            S1: begin // seen 1
                if (in) begin
                    next_state = S11;
                end else begin
                    next_state = S0;
                end
            end
            
            S11: begin // seen 11
                if (in) begin
                    next_state = S111;
                end else begin
                    next_state = S0;
                end
            end

            S111: begin // seen 111
                if (in) begin
                    next_state = S1111;
                end else begin
                    next_state = S0;
                end
            end

            S1111: begin // seen 1111
                if (in) begin
                    next_state = S11111;
                end else begin
                    next_state = S0;
                end
            end

            S11111: begin // seen 11111
                if (in) begin
                    next_state = S111111;
                end else begin
                    next_state = S0;
                end
            end

            S111111: begin // seen 111111
                if (in) begin
                    next_state = S1111111;
                    err = 1; // Error condition on next cycle
                end else begin
                    next_state = S11111;
                    flag = 1; // Flag detected
                end
            end

            S1111111: begin // Error state, seen >= 1111111
                err = 1; // Error condition
                if (!in) begin
                    next_state = S0;
                end
            end
            
            default: next_state = S0;
        endcase

        // Handle disc signal (indicating zero after five ones)
        if (state == S11111 && !in) begin
            disc = 1;
        end
    end
endmodule
