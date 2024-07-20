module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [3:0] state, next_state;
parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011, E = 4'b0100, F = 4'b0101;

always @(posedge clk, posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        A: begin
            if (w == 0)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (w == 0)
                next_state = C;
            else
                next_state = D;
        end
        C: begin
            if (w == 0)
                next_state = E;
            else
                next_state = D;
        end
        D: begin
            if (w == 0)
                next_state = F;
            else
                next_state = A;
        end
        E: begin
            if (w == 0)
                next_state = E;
            else
                next_state = D;
        end
        F: begin
            if (w == 0)
                next_state = C;
            else
                next_state = D;
        end
        default:
            next_state = A;
    endcase
end

always @(*) begin
    case (state)
        E: z = 1;
        F: z = 1;
        default: z = 0;
    endcase
end

endmodule
