module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // Parameter declaration for states
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;

    // State register
    reg [1:0] state, next_state;

    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: if (x) 
                    next_state = C;
                else 
                    next_state = A;
            B: if (x) 
                    next_state = B;
                else 
                    next_state = C;
            C: if (x) 
                    next_state = B;
                else 
                    next_state = C;
            default: next_state = A;
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
