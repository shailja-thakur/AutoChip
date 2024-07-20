module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;

always @(posedge clk or posedge reset)
    if (reset)
        state <= 3'b000;
    else if (w)
        case (state)
            3'b000: state <= 3'b001; // A (0) --1--> A
            3'b001: state <= 3'b001; // A (0) --1--> A
            3'b001: state <= 3'b100; // A (0) --0--> B
            3'b100: state <= 3'b010; // B (0) --1--> D
            3'b100: state <= 3'b101; // B (0) --0--> C
            3'b010: state <= 3'b011; // C (0) --1--> D
            3'b010: state <= 3'b010; // C (0) --0--> C
            3'b011: state <= 3'b011; // D (0) --1--> A
            3'b011: state <= 3'b101; // D (0) --0--> F
            3'b101: state <= 3'b101; // F (1) --1--> D
            3'b101: state <= 3'b100; // F (1) --0--> C
            3'b101: state <= 3'b110; // F (1) --1--> D
            default: state <= 3'b000;
        endcase
    else
        case (state)
            3'b000: state <= 3'b000; // A (0) --0--> A
            3'b001: state <= 3'b000; // A (0) --0--> A
            3'b001: state <= 3'b100; // A (0) --0--> B
            3'b100: state <= 3'b101; // B (0) --1--> C
            3'b100: state <= 3'b100; // B (0) --0--> B
            3'b010: state <= 3'b010; // C (0) --1--> D
            3'b010: state <= 3'b011; // C (0) --0--> E
            3'b011: state <= 3'b001; // D (0) --0--> A
            3'b011: state <= 3'b010; // D (0) --0--> F
            3'b101: state <= 3'b100; // F (1) --1--> C
            3'b101: state <= 3'b101; // F (1) --1--> D
            3'b101: state <= 3'b110; // F (1) --1--> D
            default: state <= 3'b000;
        endcase

always @(state)
    case (state)
        3'b011: z = 1'b0; // D (0) --0--> F
        3'b010: z = 1'b1; // D (0) --1--> A
        3'b101: z = 1'b0; // F (1) --0--> C
        3'b100: z = 1'b0; // B (0) --0--> C
        default: z = 1'b1;
    endcase

endmodule
