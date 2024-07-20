module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define state encoding
    typedef enum logic [1:0] { 
        A = 2'b00, 
        B = 2'b01, 
        C = 2'b10, 
        D = 2'b11 
    } state_t; 
    
    state_t state, next_state;

    // Combinational logic for next state and output
    always_comb begin
        case (state)
            A: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = C;
            end
            C: begin
                if (in)
                    next_state = D;
                else
                    next_state = A;
            end
            D: begin
                if (in)
                    next_state = B;
                else
                    next_state = C;
            end
            default: begin
                next_state = A;
            end
        endcase
    end

    // Sequential logic for state transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic based on the current state
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            out <= 0;
        else 
            case (state)
                A: out <= 0;
                B: out <= 0;
                C: out <= 0;
                D: out <= 1;
                default: out <= 0;
            endcase
    end
endmodule
