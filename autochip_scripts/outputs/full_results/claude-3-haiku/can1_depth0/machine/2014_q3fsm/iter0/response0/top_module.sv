module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [4:0] state, next_state;
parameter A = 5'b00001, B = 5'b00010, C = 5'b00100, S10 = 5'b01000, S11 = 5'b10000, S20 = 5'b00011, S21 = 5'b00101, S22 = 5'b01001;

always @(posedge clk, posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A: begin
            if (s)
                next_state = B;
            else
                next_state = state;
        end
        B: begin
            if (w)
                next_state = S11;
            else
                next_state = S10;
        end
        C: begin
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
        default: begin
            next_state = state;
        end
    endcase
end

always @(state) begin
    case (state)
        S20, S21, S22: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
