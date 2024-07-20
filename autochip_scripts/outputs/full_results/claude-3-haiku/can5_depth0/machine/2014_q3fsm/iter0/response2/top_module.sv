module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [4:0] state;
parameter A = 5'd0, B = 5'd1, C = 5'd2, S10 = 5'd3, S11 = 5'd4, S20 = 5'd5, S21 = 5'd6, S22 = 5'd7;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (s) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
            B: begin
                if (w) begin
                    state <= S11;
                end
                else begin
                    state <= S10;
                end
            end
            C: begin
                if (w) begin
                    state <= S11;
                end
                else begin
                    state <= S10;
                end
            end
            S10: begin
                if (w) begin
                    state <= S21;
                end
                else begin
                    state <= S20;
                end
            end
            S11: begin
                if (w) begin
                    state <= S22;
                end
                else begin
                    state <= S21;
                end
            end
            S20: begin
                state <= B;
            end
            S21: begin
                if (w) begin
                    state <= C;
                end
                else begin
                    state <= B;
                end
            end
            S22: begin
                if (w) begin
                    state <= B;
                end
                else begin
                    state <= C;
                end
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
