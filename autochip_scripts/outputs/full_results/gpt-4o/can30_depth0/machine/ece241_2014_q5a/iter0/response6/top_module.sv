module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    parameter A = 2'b00, B = 2'b01, C = 2'b10;
    reg [1:0] state, next_state;

    // Sequential logic to handle state transitions
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: next_state = x ? C : A;
            B: next_state = x ? B : C;
            C: next_state = x ? B : C;
            default: next_state = A; // should not happen
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            C: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
endmodule
