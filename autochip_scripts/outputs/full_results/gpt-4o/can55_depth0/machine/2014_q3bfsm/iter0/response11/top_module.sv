module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
    
    // Define states with a parameter
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101, // Unused
        G = 3'b110, // Unused
        H = 3'b111  // Unused
    } state_t;
    
    state_t state, next_state;
    
    // State transition on positive edge of clock or on reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A; // Reset state is A
        else
            state <= next_state;
    end
    
    // Control output and next state
    always @(*) begin
        // Default next state and output
        next_state = state;
        z = 0;
        case (state)
            A: begin
                if (x)
                    next_state = B;
                z = 0;
            end
            B: begin
                if (x)
                    next_state = E;
                z = 0;
            end
            C: begin
                if (x)
                    next_state = B;
                z = 0;
            end
            D: begin
                if (x)
                    next_state = C;
                z = 1; // Output high when in state D
            end
            E: begin
                if (!x)
                    next_state = D;
                z = 1; // Output high when in state E
            end
            default: begin
                next_state = A;
                z = 0;
            end
        endcase
    end
endmodule
