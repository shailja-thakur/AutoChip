module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);
    // State Declaration
    typedef enum logic [2:0] {
        S0, // Initial state
        S1, // Got 1
        S2, // Got 11
        S3, // Got 110
        S4  // Got 1101
    } state_t;
    
    state_t current_state, next_state;
    
    // State Transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Next State Logic
    always @* begin
        case (current_state)
            S0: begin
                if (data) next_state = S1;
                else next_state = S0;
            end
            
            S1: begin
                if (data) next_state = S2;
                else next_state = S0;
            end
            
            S2: begin
                if (data) next_state = S2;
                else next_state = S3;
            end
            
            S3: begin
                if (data) next_state = S4;
                else next_state = S0;
            end
            
            S4: begin
                next_state = S4; // Stay in S4
            end
            
            default: next_state = S0;
        endcase
    end
    
    // Output Logic
    always @(posedge clk) begin
        if (reset) begin
            start_shifting <= 1'b0;
        end else if (current_state == S4) begin
            start_shifting <= 1'b1;
        end
    end
    
endmodule
