module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define the states
    localparam A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

    // State register
    reg [2:0] state;

    // Next state logic
    always @(*) begin
        case (state)
            A: state = (w) ? B : A;
            B: state = (w) ? C : D;
            C: state = (w) ? E : D;
            D: state = (w) ? F : A;
            E: state = (w) ? E : D;
            F: state = (w) ? C : D;
        endcase
    end

    // State flip-flops
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= state;
    end

    // Output logic
    assign z = (state == E) | (state == F);

endmodule
