module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    reg [2:0] state;
    reg [2:0] next_state;

    parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;

    always @(posedge clk or posedge reset)
    begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    always @*
    begin
        case(state)
            A: begin
                if (w)
                    next_state = A;
                else
                    next_state = B;
            end
            B: begin
                if (w)
                    next_state = D;
                else
                    next_state = C;
            end
            C: begin
                if (w)
                    next_state = D;
                else
                    next_state = E;
            end
            D: begin
                if (w)
                    next_state = A;
                else
                    next_state = F;
            end
            E: begin
                if (w)
                    next_state = D;
                else
                    next_state = E;
            end
            F: begin
                if (w)
                    next_state = D;
                else
                    next_state = C;
            end
            default: next_state = A;
        endcase
    end

    assign z = (state == E || state == F) ? 1'b1 : 1'b0;

endmodule
