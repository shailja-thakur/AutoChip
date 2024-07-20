module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State registers
    reg [2:0] state;
    parameter A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (w == 0)
                    state = B;
                else
                    state = A;
            end
            B: begin
                if (w == 0)
                    state = C;
                else
                    state = D;
            end
            C: begin
                if (w == 0)
                    state = E;
                else
                    state = D;
            end
            D: begin
                if (w == 0)
                    state = F;
                else
                    state = A;
            end
            E: begin
                if (w == 0)
                    state = E;
                else
                    state = D;
            end
            F: begin
                if (w == 0)
                    state = C;
                else
                    state = D;
            end
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            E, F: z = 1;
            default: z = 0;
        endcase
    end

    // State register update
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= state;
    end

endmodule
