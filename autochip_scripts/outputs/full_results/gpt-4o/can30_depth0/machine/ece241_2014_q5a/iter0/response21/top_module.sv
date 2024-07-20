module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State parameter definitions
    parameter A = 2'b00, B = 2'b01, C = 2'b10;
    reg [1:0] state, next_state;

    // Sequential block for state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // State reset to A
        else
            state <= next_state; // State transition
    end

    // Combinational block for next state logic
    always @(*) begin
        case (state)
            A: begin
                if (x)
                    next_state = C;
                else
                    next_state = A;
            end
            B: begin
                if (x)
                    next_state = B;
                else
                    next_state = C;
            end
            C: begin
                if (x)
                    next_state = B;
                else
                    next_state = C;
            end
            default: next_state = A; // Fallback to state A in case of undefined state
        endcase
    end

    // Output logic
    always @(*) begin
        if (state == C)
            z = 1;
        else
            z = 0;
    end

endmodule
