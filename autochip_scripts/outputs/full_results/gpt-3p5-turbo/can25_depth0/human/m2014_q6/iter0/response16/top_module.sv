module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state, next_state;
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @* begin
    case (state)
        A: begin
            if (w)
                next_state = A;
            else
                next_state = B;
        end
        B: begin
            case (w)
                0: next_state = C;
                1: next_state = D;
            endcase
        end
        C: begin
            case (w)
                0: next_state = E;
                1: next_state = D;
            endcase
        end
        D: begin
            case (w)
                0: next_state = F;
                1: next_state = A;
            endcase
        end
        E: begin
            case (w)
                0: next_state = E;
                1: next_state = D;
            endcase
        end
        F: begin
            case (w)
                0: next_state = C;
                1: next_state = D;
            endcase
        end
        default: next_state = A;
    endcase
end

always @(posedge clk) begin
    case (state)
        A: z = 0;
        B: z = 0;
        C: z = 0;
        D: z = 0;
        E: z = 1;
        F: z = 1;
        default: z = 0;
    endcase
end

endmodule
