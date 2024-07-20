module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    reg [3:0] state, next_state;
    parameter A = 0, B = 1, C = 2, S10 = 3, S11 = 4, S20 = 5, S21 = 6, S22 = 7;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    always @* begin
        case (state)
            A: if (s) next_state = B;
               else next_state = A;
            B: if (w) next_state = S11;
               else next_state = S10;
            C: if (w) next_state = S11;
               else next_state = S10;
            S10: if (w) next_state = S21;
                 else next_state = S20;
            S11: if (w) next_state = S22;
                 else next_state = S21;
            S20: next_state = B;
            S21: if (w) next_state = C;
                 else next_state = B;
            S22: if (w) next_state = B;
                 else next_state = C;
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            z <= 0; // Initialize z to 0
        end
        else begin
            case (state)
                A, B, C, S10, S11, S20: z <= 0; // Fix: Removed S21, S22 from this case
                S21: z <= 1; // Set z to 1 for state S21
                S22: z <= 0; // Set z to 0 for state S22
            endcase
        end
    end

endmodule
