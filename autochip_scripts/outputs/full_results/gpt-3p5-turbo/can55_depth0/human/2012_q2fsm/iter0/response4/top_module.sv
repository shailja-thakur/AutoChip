module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state, next_state;

parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;

always @(posedge clk, posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A: begin
            if (w)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (w)
                next_state = C;
            else
                next_state = D;
        end
        C: begin
            if (w)
                next_state = E;
            else
                next_state = D;
        end
        D: begin
            if (w)
                next_state = F;
            else
                next_state = A;
        end
        E: begin
            if (w)
                next_state = E;
            else
                next_state = D;
        end
        F: begin
            if (w)
                next_state = C;
            else
                next_state = D;
        end
    endcase
end

always @(state) begin
    case (state)
        A: z = 0;
        B: z = 0;
        C: z = 0;
        D: z = 0;
        E: z = 1;
        F: z = 1;
    endcase
end

endmodule
