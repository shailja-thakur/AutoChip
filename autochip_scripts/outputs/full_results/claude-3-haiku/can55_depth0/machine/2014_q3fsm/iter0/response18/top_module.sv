module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [2:0] state;
parameter A = 3'd0, B = 3'd1, C = 3'd2, S10 = 3'd3, S11 = 3'd4, S20 = 3'd5, S21 = 3'd6, S22 = 3'd7;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
        z <= 1'b0;
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
                z <= 1'b0;
            end
            B: begin
                if (w) begin
                    state <= S11;
                end
                else begin
                    state <= S10;
                end
                z <= 1'b0;
            end
            C: begin
                if (w) begin
                    state <= S11;
                end
                else begin
                    state <= S10;
                end
                z <= 1'b0;
            end
            S10: begin
                if (w) begin
                    state <= S21;
                end
                else begin
                    state <= S20;
                end
                z <= 1'b0;
            end
            S11: begin
                if (w) begin
                    state <= S22;
                end
                else begin
                    state <= S21;
                end
                z <= 1'b0;
            end
            S20: begin
                state <= B;
                z <= 1'b0;
            end
            S21: begin
                if (w) begin
                    state <= C;
                end
                else begin
                    state <= B;
                end
                z <= 1'b0;
            end
            S22: begin
                if (w) begin
                    state <= B;
                end
                else begin
                    state <= C;
                end
                z <= 1'b0;
            end
            default: begin
                state <= A;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
