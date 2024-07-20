module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [4:0] state;
parameter A = 5'b00001, B = 5'b00010, C = 5'b00100, S10 = 5'b01000, S11 = 5'b10000, S20 = 5'b00101, S21 = 5'b00110, S22 = 5'b00111;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= A;
    end
    else begin
        case (state)
            A: if (s) state <= B;
            B: if (w) state <= S11; else state <= S10;
            C: if (w) state <= S11; else state <= S10;
            S10: if (w) state <= S21; else state <= S20;
            S11: if (w) state <= S22; else state <= S21;
            S20: state <= B;
            S21: if (w) state <= C; else state <= B;
            S22: if (w) state <= B; else state <= C;
        endcase
    end
end

always @(*) begin
    case (state)
        A: z = 0;
        B: z = 0;
        C: z = 0;
        S10: z = 0;
        S11: z = 0;
        S20: z = 0;
        S21: z = 0;
        S22: z = 0;
    endcase
end

endmodule
