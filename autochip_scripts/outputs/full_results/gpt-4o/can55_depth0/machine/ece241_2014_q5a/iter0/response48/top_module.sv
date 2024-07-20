module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // state encoding
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;

    reg [1:0] state, next_state;

    // state transition
    always @ (posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // next state logic
    always @ (*) begin
        case (state)
            A: next_state = x ? C : A;
            B: next_state = x ? B : C;
            C: next_state = x ? B : C;
            default: next_state = A;
        endcase
    end

    // output logic
    always @ (*) begin
        z = (state == C);
    end
endmodule
