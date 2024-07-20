module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [4:0] state;
parameter A = 5'b00000, B = 5'b00001, C = 5'b00010, S10 = 5'b00011, S11 = 5'b00100, S20 = 5'b00101, S21 = 5'b00110, S22 = 5'b00111;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (s) state <= B;
                else state <= state;
            end
            B: begin
                if (w) state <= S11;
                else state <= S10;
            end
            C: begin
                if (w) state <= S11;
                else state <= S10;
            end
            S10: begin
                if (w) state <= S21;
                else state <= S20;
            end
            S11: begin
                if (w) state <= S22;
                else state <= S21;
            end
            S20: begin
                state <= B;
            end
            S21: begin
                if (w) state <= C;
                else state <= B;
            end
            S22: begin
                if (w) state <= B;
                else state <= C;
            end
            default: begin
                state <= A;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        A: z = 1'b0;
        B: z = 1'b0;
        C: z = 1'b0;
        S10: z = 1'b0;
        S11: z = 1'b0;
        S20: z = 1'b0;
        S21: z = 1'b0;
        S22: z = 1'b0;
        default: z = 1'b0;
    endcase
end

endmodule
