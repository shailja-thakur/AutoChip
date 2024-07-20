module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [2:0] state;
parameter A = 3'b000, B = 3'b001, C = 3'b010, S10 = 3'b011, S11 = 3'b100, S20 = 3'b101, S21 = 3'b110, S22 = 3'b111;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (s) state <= B;
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
        endcase
    end
end

always @(*) begin
    case (state)
        S10, S20: z = 1'b0;
        S11, S21, S22: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
