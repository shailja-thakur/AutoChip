module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [2:0] state;
parameter A = 3'b000, B = 3'b001, C = 3'b010, S10 = 3'b011, S11 = 3'b100, S20 = 3'b101, S21 = 3'b110, S22 = 3'b111;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
    end
    else begin
        case (state)
            A: if (s) state <= B;
            B: if (w) state <= S11;
               else state <= S10;
            C: if (w) state <= S11;
               else state <= S10;
            S10: if (w) state <= S21;
                 else state <= S20;
            S11: if (w) state <= S22;
                 else state <= S21;
            S20: state <= B;
            S21: if (w) state <= C;
                 else state <= B;
            S22: if (w) state <= B;
                 else state <= C;
        endcase
    end
end

always @(*) begin
    case (state)
        S20, S21, S22: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
