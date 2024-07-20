module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    
    parameter A = 2'b00, B = 2'b01, C = 2'b10;
    reg [1:0] state, next_state;

    // State Transition Logic: Synchronous always block
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Reset state to A
        else
            state <= next_state; // Move to next state
    end

    // Next State Logic: Combinational always block
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
            default: next_state = A; // default case to handle invalid state
        endcase
    end

    // Output Logic: Combinational always block
    always @(*) begin
        z = (state == C) ? 1'b1 : 1'b0;
    end

endmodule
