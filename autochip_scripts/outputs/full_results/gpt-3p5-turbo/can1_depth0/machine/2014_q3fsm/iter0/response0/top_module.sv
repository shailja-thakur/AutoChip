module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Define the states
    parameter A = 0;
    parameter B = 1;
    parameter C = 2;
    parameter S10 = 3;
    parameter S11 = 4;
    parameter S20 = 5;
    parameter S21 = 6;
    parameter S22 = 7;

    // Define the state signals
    reg [2:0] state;
    reg [2:0] next_state;

    // Define the state transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Define the next state logic
    always @(state or s or w) begin
        case (state)
            A: if (s) begin
                    next_state = B;
                end else begin
                    next_state = state;
                end
            B: if (w) begin
                    next_state = S11;
                end else begin
                    next_state = S10;
                end
            C: if (w) begin
                    next_state = S11;
                end else begin
                    next_state = S10;
                end
            S10: if (w) begin
                    next_state = S21;
                end else begin
                    next_state = S20;
                end
            S11: if (w) begin
                    next_state = S22;
                end else begin
                    next_state = S21;
                end
            S20: next_state = B;
            S21: if (w) begin
                    next_state = C;
                end else begin
                    next_state = B;
                end
            S22: if (w) begin
                    next_state = B;
                end else begin
                    next_state = C;
                end
            default: next_state = state;
        endcase
    end

    // Define the output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            z <= 0;
        end else begin
            case (state)
                A: z <= 0;
                B: z <= 0;
                C: z <= 0;
                S10: z <= 0;
                S11: z <= 0;
                S20: z <= 0;
                S21: z <= 0;
                S22: z <= 0;
                default: z <= 0;
            endcase
        end
    end

endmodule
