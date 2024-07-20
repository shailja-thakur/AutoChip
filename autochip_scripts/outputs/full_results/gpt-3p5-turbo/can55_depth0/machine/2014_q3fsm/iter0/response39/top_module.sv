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

// Declare state variable
reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else if (s)
        state <= B;
    else begin
        case (state)
            B: begin
                if (w)
                    state <= S11;
                else
                    state <= S10;
            end
            C: begin
                if (w)
                    state <= S11;
                else
                    state <= S10;
            end
            S10: begin
                if (w)
                    state <= S21;
                else
                    state <= S20;
            end
            S11: begin
                if (w)
                    state <= S22;
                else
                    state <= S21;
            end
            S20: state <= B;
            S21: begin
                if (w)
                    state <= C;
                else
                    state <= B;
            end
            S22: begin
                if (w)
                    state <= B;
                else
                    state <= C;
            end
        endcase
    end
end

// Output logic
always @(state) begin
    case (state)
        B, C, S10, S11: z <= 1;
        default: z <= 0;
    endcase
end

endmodule
