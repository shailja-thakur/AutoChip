module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define states as parameters
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state;

    // State transition process
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;        // Asynchronous reset to state A
        end
        else begin
            case (state)
                A: state <= x ? B : A; // Transition from A to B if x is 1
                B: state <= B;         // Stay in state B
                default: state <= A;   // Default state
            endcase
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            A: z = x ? 1 : 0; // Output 1 if in state A and x is 1
            B: z = x ? 0 : 1; // Output 1 if in state B and x is 0
            default: z = 0;   // Default output
        endcase
    end

endmodule
