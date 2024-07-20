module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [3:0] state, next_state;
parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011,
          E = 4'b0100, F = 4'b0101;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
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
        default:
            next_state = A;
    endcase
end

always @(state) begin
    case (state)
        E, F: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
