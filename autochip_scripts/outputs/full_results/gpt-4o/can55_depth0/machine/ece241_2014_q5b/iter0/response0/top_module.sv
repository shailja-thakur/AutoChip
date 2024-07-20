module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    parameter A = 1'b0, B = 1'b1;

    // Register to store the current state
    reg state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Asynchronous reset to state A
        else begin
            case (state)
                A: if (x) state <= B;
                   else state <= A;
                B: state <= B;  // state remains B
                default: state <= A; // default to A for safety
            endcase
        end
    end

    always @(state or x) begin
        case (state)
            A: z = x;
            B: z = ~x;
            default: z = 0; // default to 0 for safety
        endcase
    end

endmodule
