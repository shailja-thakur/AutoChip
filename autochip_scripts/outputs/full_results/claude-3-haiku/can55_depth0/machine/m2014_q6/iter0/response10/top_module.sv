module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state, next_state;
parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

always @(posedge clk) begin
    if (reset) state <= A;
    else state <= next_state;
end

always @(*) begin
    case (state)
        A: begin
            if (w) next_state = A;
            else next_state = B;
        end
        B: begin
            if (w) next_state = D;
            else next_state = C;
        end
        C: begin
            if (w) next_state = D;
            else next_state = E;
        end
        D: begin
            if (w) next_state = A;
            else next_state = F;
        end
        E: begin
            if (w) next_state = D;
            else next_state = E;
        end
        F: begin
            if (w) next_state = D;
            else next_state = C;
        end
    endcase
end

always @(*) begin
    case (state)
        E, F: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
