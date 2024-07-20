module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state;
parameter A = 4'b0001, B = 4'b0010, C = 4'b0011, S10 = 4'b0100, S11 = 4'b0101, S20 = 4'b0110, S21 = 4'b0111, S22 = 4'b1000;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
        z <= 1'b0;
    end
    else begin
        case (state)
            A: // state A: If s is asserted, next state is B
                if (s) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            B: // state B: If w is asserted, next state is S11, otherwise next state is S10
                if (w) begin
                    state <= S11;
                end
                else begin
                    state <= S10;
                end
            C: // state C: If w is asserted, next state is S11, otherwise next state is S10
                if (w) begin
                    state <= S11;
                end
                else begin
                    state <= S10;
                end
            S10: // state S10: If w is asserted, next state is S21, otherwise next state is S20
                if (w) begin
                    state <= S21;
                end
                else begin
                    state <= S20;
                end
            S11: // state S11: If w is asserted, next state is S22, otherwise next state is S21
                if (w) begin
                    state <= S22;
                end
                else begin
                    state <= S21;
                end
            S20: // state S20: next state is B
                state <= B;
            S21: // state S21: If w is asserted, next state is C, otherwise next state is B
                if (w) begin
                    state <= C;
                end
                else begin
                    state <= B;
                end
            S22: // state S22: If w is asserted, next state is B, otherwise next state is C
                if (w) begin
                    state <= B;
                end
                else begin
                    state <= C;
                end
            default:
                state <= A;
        endcase
    end
end

always @(*) begin
    case (state)
        A, B, S20: z = 1'b0;
        C, S10, S11, S21, S22: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
