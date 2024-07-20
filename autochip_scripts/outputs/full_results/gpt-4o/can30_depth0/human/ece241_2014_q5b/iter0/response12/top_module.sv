module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // One-hot encoding state definitions
    reg state, next_state;
    localparam A = 1'b0, B = 1'b1;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: if (x) next_state = B;
               else next_state = A;
            B: next_state = B;
            default: next_state = A; // default case
        endcase
    end

    // Output logic (combinational)
    always @(*) begin
        case (state)
            A: z = x;
            B: z = ~x;
            default: z = 0; // default case
        endcase
    end

    // State register (sequential), asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) state <= A;
        else state <= next_state;
    end

endmodule
