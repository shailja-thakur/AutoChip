module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [2:0] state, next_state;

    // State assignments
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;

    always @(posedge clk, posedge reset)
    begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    always @(state, w)
    begin
        case(state)
            A: begin
                if (w == 0)
                    next_state = B;
                else
                    next_state = A;
            end

            B: begin
                if (w == 1)
                    next_state = D;
                else
                    next_state = C;
            end

            C: begin
                if (w == 1)
                    next_state = D;
                else
                    next_state = E;
            end

            D: begin
                if (w == 1)
                    next_state = A;
                else
                    next_state = F;
            end

            E: begin
                if (w == 1)
                    next_state = D;
                else
                    next_state = E;
            end

            F: begin
                if (w == 1)
                    next_state = D;
                else
                    next_state = C;
            end
        endcase
    end

    always @(state)
    begin
        if (state == E || state == F)
            z = 1'b1;
        else
            z = 1'b0;
    end

endmodule
