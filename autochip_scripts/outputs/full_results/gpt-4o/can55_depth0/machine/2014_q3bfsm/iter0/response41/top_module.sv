module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // Define states using local parameters
    localparam A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100;

    reg [2:0] state, next_state;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A; // Initialize state to A on reset
        else
            state <= next_state;
    end

    // Combinate logic for next state and output
    always @(*) begin
        // Default values
        next_state = state;
        z = 1'b0;
        case (state)
            A: 
                if (x) 
                    next_state = B;
                else 
                    next_state = A;
            B: 
                if (x) 
                    next_state = E;
                else 
                    next_state = B;
            C: 
                if (x)
                    next_state = B;
                else 
                    next_state = C;
            D: 
                if (x) 
                    next_state = C;
                else 
                    next_state = B;
            E: 
                if (x) 
                    next_state = E;
                else 
                    next_state = D;
        endcase
        // Output logic
        if (state == D || state == E)
            z = 1'b1;
    end
endmodule
