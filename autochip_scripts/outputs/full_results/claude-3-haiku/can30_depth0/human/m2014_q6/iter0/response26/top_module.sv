module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define the states
    localparam A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;

    // State register
    reg [2:0] state, next_state;

    // Next state logic
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
            default: next_state = A;
        endcase
    end

    // State register update
    always @(posedge clk or posedge reset) begin
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
