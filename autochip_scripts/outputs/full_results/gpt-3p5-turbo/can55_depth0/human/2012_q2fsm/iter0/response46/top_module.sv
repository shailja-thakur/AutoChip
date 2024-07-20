module top_module (
    input clk,   // Clock signal
    input reset, // Reset signal
    input w,     // Input signal
    output reg z // Output signal
);

    // Define states
    parameter A = 2'b00; // State A
    parameter B = 2'b01; // State B
    parameter C = 2'b10; // State C
    parameter D = 2'b11; // State D
    parameter E = 2'b100; // State E
    parameter F = 2'b101; // State F

    // Define next state variable
    reg [2:0] next_state;

    // Define current state variable
    reg [2:0] state;

    // State transition and output logic
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            state <= A; // Reset state
        else
            state <= next_state; // Go to next state

        case (state)
            A: begin
                if (w)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (w)
                    next_state = C;
                else
                    next_state = D;
            end
            C: begin
                if (w)
                    next_state = E;
                else
                    next_state = D;
            end
            D: begin
                if (w)
                    next_state = F;
                else
                    next_state = A;
            end
            E: begin
                if (w)
                    next_state = E;
                else
                    next_state = D;
            end
            F: begin
                if (w)
                    next_state = C;
                else
                    next_state = D;
            end
        endcase
    end

    // Output assignment
    always @(state, w)
    begin
        case (state)
            A, B, C: z = 0; // Output z is 0 for states A, B and C
            D, E, F: z = 1; // Output z is 1 for states D, E and F
        endcase
    end

endmodule
