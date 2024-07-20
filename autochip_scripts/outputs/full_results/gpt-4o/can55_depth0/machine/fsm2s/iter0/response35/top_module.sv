module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State encoding
    parameter A = 1'b0;
    parameter B = 1'b1;

    reg state, next_state;

    // State transition
    always @ (posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
    always @ (*) begin
        case (state)
            A: begin
                if (j)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (k)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = A; // Should not be needed
        endcase
    end
    
    // Output logic
    always @ (*) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0; // Should not be needed
        endcase
    end

endmodule
