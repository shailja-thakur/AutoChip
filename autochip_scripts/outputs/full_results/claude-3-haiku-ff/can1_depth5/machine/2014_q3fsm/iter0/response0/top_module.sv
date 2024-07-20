module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state;
parameter A = 4'd0, B = 4'd1, C = 4'd2, S10 = 4'd3, S11 = 4'd4, S20 = 4'd5, S21 = 4'd6, S22 = 4'd7;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
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
        S20, S21, S22: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
