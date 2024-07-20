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
        S0 = 3'b000,  // Initial state
        S1 = 3'b001,  // Saw 0
        S2 = 3'b010,  // Saw 01
        S3 = 3'b011,  // Saw 011
        S4 = 3'b100,  // Saw 0111
        S5 = 3'b101,  // Saw 01111
        S6 = 3'b110,  // Saw 011111
        S7 = 3'b111   // Saw 0111111
    } state_t;
    
    state_t state, next_state;
    
    // State transition
    always_ff @(posedge clk) begin
        if (reset)
            state <= S1;   // Starting with "previous input were 0"
        else
            state <= next_state;
    end
    
    // Next state logic
    always_comb begin
        // Default outputs
        next_state = state;
        disc = 0;
        flag = 0;
        err = 0;
        
        case (state)
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
                    disc = 1;  // Signal bit to be discarded
                end
            end
            S7: begin
                if (in) begin
                    next_state = S7;
                    err = 1;  // Error: more than 6 consecutive 1s
                end
                else begin
                    next_state = S1;
                    flag = 1;  // Flag indicates frame boundaries
                end
            end
        endcase
    end
endmodule
