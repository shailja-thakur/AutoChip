module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    // State encoding
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11, E = 2'b11, F = 2'b11;

    reg [1:0] state, next_state;

    // State table
    always @(*) begin
        case (state)
            A: next_state = (w) ? B : A;
            B: next_state = (w) ? C : D;
            C: next_state = (w) ? E : D;
            D: next_state = (w) ? F : A;
            E: next_state = (w) ? E : D;
            F: next_state = (w) ? C : D;
            default: next_state = A;
        endcase
    end

    // State flip-flops
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    assign z = (state == E) || (state == F);

endmodule
