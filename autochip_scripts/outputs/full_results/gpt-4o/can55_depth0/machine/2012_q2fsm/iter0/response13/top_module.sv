module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    // state encoding
    localparam A = 3'b000;
    localparam B = 3'b001;
    localparam C = 3'b010;
    localparam D = 3'b011;
    localparam E = 3'b100;
    localparam F = 3'b101;
    
    reg [2:0] state, next_state;

    // next state logic
    always @(*) begin
        case (state)
            A: next_state = (w) ? B : A;
            B: next_state = (w) ? C : D;
            C: next_state = (w) ? E : D;
            D: next_state = (w) ? F : A;
            E: next_state = (w) ? E : D;
            F: next_state = (w) ? C : D;
            default: next_state = A; // default case to reset state
        endcase
    end

    // state register with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A; // reset to state A
        else
            state <= next_state; // transition to next state
    end

    // output logic
    assign z = (state == E) || (state == F);
endmodule
