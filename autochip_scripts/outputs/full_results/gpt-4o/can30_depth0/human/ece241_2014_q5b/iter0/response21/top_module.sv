module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State encoding using one-hot
    reg [1:0] state, next_state;
    localparam A = 2'b01, B = 2'b10;

    // State transitions
    always @(*) begin
        case(state)
            A: if (x) next_state = B;
               else next_state = A;
            B: if (x) next_state = B;
               else next_state = B;
            default: next_state = A; // Safe state assignment
        endcase
    end

    // Output logic
    always @(*) begin
        case(state)
            A: z = x ? 1'b1 : 1'b0;
            B: z = x ? 1'b0 : 1'b1;
            default: z = 1'b0; // Safe output assignment
        endcase
    end

    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
endmodule
