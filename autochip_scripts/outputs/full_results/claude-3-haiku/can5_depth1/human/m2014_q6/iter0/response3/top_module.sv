module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [2:0] state, next_state;
    parameter A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (w == 0) next_state = B;
                else next_state = A;
            end
            B: begin
                if (w == 0) next_state = C;
                else next_state = D;
            end
            C: begin
                if (w == 0) next_state = E;
                else next_state = D;
            end
            D: begin
                if (w == 0) next_state = F;
                else next_state = A;
            end
            E: begin
                if (w == 0) next_state = E;
                else next_state = D;
            end
            F: begin
                if (w == 0) next_state = C;
                else next_state = D;
            end
            default: next_state = A;
        endcase
    end

    // State register
    always @(posedge clk, posedge reset) begin
        if (reset) state <= A;
        else state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            E, F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
