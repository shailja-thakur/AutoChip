module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    reg [2:0] state, next_state;

    always @(posedge clk, posedge reset) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    always @(state, s, w) begin
        case (state)
            B:
                if (s)
                    next_state = C;
                else if (w)
                    next_state = S11;
                else
                    next_state = S10;
            C:
                if (w)
                    next_state = S11;
                else
                    next_state = S10;
            S10:
                if (w)
                    next_state = S21;
                else
                    next_state = S20;
            S11:
                if (w)
                    next_state = S22;
                else
                    next_state = S21;
            S20:
                next_state = B;
            S21:
                if (w)
                    next_state = C;
                else
                    next_state = B;
            S22:
                if (w)
                    next_state = B;
                else
                    next_state = C;
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            z <= 0;
        else
            case (state)
                B:
                    z <= 0;
                C:
                    z <= 0;
                S10:
                    z <= 0;
                S11:
                    z <= 0;
                S20:
                    z <= 1;
                S21:
                    z <= 0;
                S22:
                    z <= 0;
            endcase
    end
endmodule
