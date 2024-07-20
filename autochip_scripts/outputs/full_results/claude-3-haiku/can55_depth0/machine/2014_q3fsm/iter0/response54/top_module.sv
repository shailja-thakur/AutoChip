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
        z <= 0;
    end
    else begin
        case (state)
            A: begin
                if (s) state <= B;
                else state <= state;
                z <= 0;
            end
            B: begin
                if (w) state <= S11;
                else state <= S10;
                z <= 0;
            end
            C: begin
                if (w) state <= S11;
                else state <= S10;
                z <= 0;
            end
            S10: begin
                if (w) state <= S21;
                else state <= S20;
                z <= 0;
            end
            S11: begin
                if (w) state <= S22;
                else state <= S21;
                z <= 0;
            end
            S20: begin
                state <= B;
                z <= 0;
            end
            S21: begin
                if (w) state <= C;
                else state <= B;
                z <= 0;
            end
            S22: begin
                if (w) state <= B;
                else state <= C;
                z <= 0;
            end
            default: begin
                state <= A;
                z <= 0;
            end
        endcase
    end
end

endmodule
