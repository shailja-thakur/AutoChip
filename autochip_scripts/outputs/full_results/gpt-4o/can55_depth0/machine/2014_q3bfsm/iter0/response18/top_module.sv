module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // Define states using parameters
    parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100;

    // Internal state register
    reg [2:0] state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: next_state = x ? B : A;
            B: next_state = x ? E : B;
            C: next_state = x ? B : C;
            D: next_state = x ? C : B;
            E: next_state = x ? E : D;
            default: next_state = A;
        endcase
    end

    // State register (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic (combinational)
    always @(*) begin
        case (state)
            D, E: z = 1;
            default: z = 0;
        endcase
    end

endmodule
