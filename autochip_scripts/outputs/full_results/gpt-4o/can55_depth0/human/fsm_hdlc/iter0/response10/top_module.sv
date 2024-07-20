module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum reg [2:0] {
        S0,  // Initial state, previous input assumed to be 0
        S1,  // Detected 0
        S2,  // Detected 01
        S3,  // Detected 011
        S4,  // Detected 0111
        S5,  // Detected 01111
        S6,  // Detected 011111
        S7,  // Detected 0111111
        S8   // Detected 01111111 (Error state)
    } state_t;
    
    state_t current_state, next_state;
    
    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        // Default values
        next_state = current_state;
        disc = 0;
        flag = 0;
        err = 0;
        
        case (current_state)
            S0: begin
                if (in) next_state = S0;
                else next_state = S1;
            end
            S1: begin
                if (in) next_state = S2;
                else next_state = S1;
            end
            S2: begin
                if (in) next_state = S3;
                else next_state = S1;
            end
            S3: begin
                if (in) next_state = S4;
                else next_state = S1;
            end
            S4: begin
                if (in) next_state = S5;
                else next_state = S1;
            end
            S5: begin
                if (in) next_state = S6;
                else next_state = S1;
            end
            S6: begin
                if (in) next_state = S7;
                else begin
                    next_state = S1;
                    disc = 1;
                end
            end
            S7: begin
                if (in) begin
                    next_state = S8;  // Error state
                    err = 1;
                end else begin
                    next_state = S1;
                    flag = 1;
                end
            end
            S8: begin
                if (~in) begin
                    next_state = S1;
                    err = 1;  // Maintain error until reset
                end else begin
                    next_state = S8;  // Stay in error state
                end
            end
            default: next_state = S0;
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else if (current_state == S6 && in == 0) begin
            disc <= 1;
        end else if (current_state == S7 && in == 0) begin
            flag <= 1;
        end else if (current_state == S8) begin
            err <= 1;
        end else begin
            disc <= 0;
            flag <= 0;
            err <= (current_state == S8);
        end
    end
endmodule
