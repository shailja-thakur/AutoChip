module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Define the states
    typedef enum logic [3:0] {
        A,
        B,
        C,
        S10,
        S11,
        S20,
        S21,
        S22
    } state_type;
    
    // Define the current state and next state variables
    reg [3:0] current_state;
    reg [3:0] next_state;
    
    // Assign initial state
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end
    
    // Assign next state based on the state machine logic
    always @(current_state, s, w) begin
        case (current_state)
            A: begin
                if (s)
                    next_state <= B; // Use non-blocking assignment
                else
                    next_state <= A;
            end
            B, C: begin
                if (w)
                    next_state <= S11;
                else
                    next_state <= S10;
            end
            S10: begin
                if (w)
                    next_state <= S21;
                else
                    next_state <= S20;
            end
            S11: begin
                if (w)
                    next_state <= S22;
                else
                    next_state <= S21;
            end
            S20: next_state <= B;
            S21: begin
                if (w)
                    next_state <= C;
                else
                    next_state <= B;
            end
            S22: begin
                if (w)
                    next_state <= B;
                else
                    next_state <= C;
            end
        endcase
    end
    
    // Output logic
    always @(posedge clk) begin // Use posedge clk for synchronous output update
        case (current_state)
            A: z <= s; // Use non-blocking assignment
            B, C, S10, S11, S21, S22: z <= 0;
            S20: z <= 1;
        endcase
    end

endmodule
