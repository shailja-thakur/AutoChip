module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // Parameter declaration for state A and B
    parameter A = 1'b0, B = 1'b1;
    
    // Register to hold the state
    reg state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;  // Asynchronous reset to state A
        end else begin
            case (state)
                A: begin
                    if (x) begin
                        state <= B;  // Transition to state B on rising edge of x
                    end else begin
                        state <= A;  // Remain in state A
                    end
                end
                B: begin
                    state <= B;  // Stay in state B
                end
            endcase
        end
    end
    
    // Output logic
    always @(*) begin
        case (state)
            A: z = x ? 1'b1 : 1'b0;  // Set z to 1 if state is A and x is 1
            B: z = x ? 1'b0 : 1'b1;  // Set z to 1 if state is B and x is 0
            default: z = 1'b0;
        endcase
    end
endmodule
