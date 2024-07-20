module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // Defining states A and B using parameter
    parameter A = 1'b0, B = 1'b1;

    // State register
    reg state;

    // State transition on clock posedge or asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A; // When areset is asserted, go to state A
        end else begin
            case (state)
                A: state <= (x) ? B : A; // Transition from A to B if x is 1
                B: state <= B;           // Stay in B
                default: state <= A;     // Default to state A
            endcase
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            A: z = (x) ? 1'b1 : 1'b0; // z is 1 if state is A and x is 1
            B: z = (x) ? 1'b0 : 1'b1; // z is 1 if state is B and x is 0
            default: z = 1'b0;        // Default z to 0
        endcase
    end

endmodule
