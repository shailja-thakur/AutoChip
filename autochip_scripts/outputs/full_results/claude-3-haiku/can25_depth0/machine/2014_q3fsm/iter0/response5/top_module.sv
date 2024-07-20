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
        S22: z = 1'b1;
    endcase
end

endmodule
