module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [2:0] state, next_state;
parameter A = 3'd0, B = 3'd1, C = 3'd2, S10 = 3'd3, S11 = 3'd4, S20 = 3'd5, S21 = 3'd6, S22 = 3'd7;

always @(posedge clk or posedge reset) begin
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
    endcase
end

always @(*) begin
    case (state)
        A: z = 1'b0;
        B: z = 1'b0;
        C: z = 1'b0;
        S10: z = 1'b0;
        S11: z = 1'b0;
        S20: z = 1'b0;
        S21: z = 1'b0;
        S22: z = 1'b0;
    endcase
end

endmodule
