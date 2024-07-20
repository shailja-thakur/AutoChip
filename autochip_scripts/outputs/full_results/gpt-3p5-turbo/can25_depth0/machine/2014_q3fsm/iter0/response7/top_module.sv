module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// Define states
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter S10 = 3;
parameter S11 = 4;
parameter S20 = 5;
parameter S21 = 6;
parameter S22 = 7;

// Define current state and next state variables
reg [2:0] state;
reg [2:0] next_state;

// Initialize state with A
always @ (posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

// Determine the next state based on the current state and inputs
always @* begin
    case (state)
        A:
            if (s)
                next_state = B;
            else
                next_state = state;
        B, C:
            if (w)
                next_state = S11;
            else
                next_state = S10;
        S10:
            if (w)
                next_state = S21;
            else
                next_state = S20;
        S11:
            if (w)
                next_state = S22;
            else
                next_state = S21;
        S20:
            next_state = B;
        S21:
            if (w)
                next_state = C;
            else
                next_state = B;
        S22:
            if (w)
                next_state = B;
            else
                next_state = C;
        default:
            next_state = state;
    endcase
end

// Assign outputs based on current state
always @ (posedge clk or posedge reset) begin
    if (reset)
        z <= 0;
    else begin
        case (state)
            A: z <= 0;
            B, C, S10, S21: z <= 1;
            S11, S20, S22: z <= 0;
            default: z <= 0;
        endcase
    end
end

endmodule
