module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state;
parameter A = 4'd0, B = 4'd1, C = 4'd2, S10 = 4'd3, S11 = 4'd4, S20 = 4'd5, S21 = 4'd6, S22 = 4'd7;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
        z <= 0;
    end
    else begin
        case (state)
            A: begin
                if (s) begin
                    state <= B;
                end
                else begin
                    state <= state;
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
        endcase
    end
end

endmodule
