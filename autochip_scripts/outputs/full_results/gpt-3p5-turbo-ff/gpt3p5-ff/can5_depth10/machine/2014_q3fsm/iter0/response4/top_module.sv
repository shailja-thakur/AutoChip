module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// States
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter S10 = 3;
parameter S11 = 4;
parameter S20 = 5;
parameter S21 = 6;
parameter S22 = 7;

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @* begin
    next_state = state; // Default next state

    case (state)
        A: begin
            if (s)
                next_state = B;
        end

        B, C: begin
            if (w)
                next_state = S11;
            else
                next_state = S10;
        end

        S10: begin
            if (w)
                next_state = S21;
            else
                next_state = S20;
        end

        S11: begin
            if (w)
                next_state = S22;
            else
                next_state = S21;
        end

        S20: begin
            next_state = B;
        end

        S21: begin
            if (w)
                next_state = C;
            else
                next_state = B;
        end

        S22: begin
            if (w)
                next_state = B;
            else
                next_state = C;
        end
    endcase
end

always @(posedge clk) begin
    if (reset)
        z <= 0;
    else begin
        case (state)
            A: begin
                if (s)
                    z <= 1;
            end

            B, C, S10, S11, S20, S21, S22: begin
                z <= 0;
            end
        endcase
    end
end

endmodule
