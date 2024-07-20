module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state;
localparam A = 4'b0000, B = 4'b0001, C = 4'b0010, S10 = 4'b0011, S11 = 4'b0100, S20 = 4'b0101, S21 = 4'b0110, S22 = 4'b0111;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
        z <= 0;
    end
    else begin
        case (state)
            A: // state A
                if (s) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            B: // state B
                if (w) begin
                    state <= S11;
                end
                else begin
                    state <= S10;
                end
            C: // state C
                if (w) begin
                    state <= S11;
                end
                else begin
                    state <= S10;
                end
            S10: // state S10
                if (w) begin
                    state <= S21;
                end
                else begin
                    state <= S20;
                end
            S11: // state S11
                if (w) begin
                    state <= S22;
                end
                else begin
                    state <= S21;
                end
            S20: // state S20
                state <= B;
            S21: // state S21
                if (w) begin
                    state <= C;
                end
                else begin
                    state <= B;
                end
            S22: // state S22
                if (w) begin
                    state <= B;
                end
                else begin
                    state <= C;
                end
        endcase
    end
end

endmodule
