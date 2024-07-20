module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define state encoding using parameters
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;

    // State register
    reg [2:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (w == 0) ? A : B;
            B: next_state = (w == 0) ? D : C;
            C: next_state = (w == 0) ? D : E;
            D: next_state = (w == 0) ? A : F;
            E: next_state = (w == 0) ? D : E;
            F: next_state = (w == 0) ? D : C;
            default: next_state = A;
        endcase
    end

    // State register update
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        if (state == E || state == F)
            z = 1;
        else
            z = 0;
    end
endmodule
