module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state;
parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, S10 = 4'b0011, S11 = 4'b0100, S20 = 4'b0101, S21 = 4'b0110, S22 = 4'b0111;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
        z <= 1'b0;
    end
    else begin
        case (state)
            A: begin
                if (s) state <= B;
                else state <= A;
                z <= 1'b0;
            end
            B: begin
                if (w) state <= S11;
                else state <= S10;
                z <= 1'b1;
            end
            C: begin
                if (w) state <= S11;
                else state <= S10;
                z <= 1'b1;
            end
            S10: begin
                if (w) state <= S21;
                else state <= S20;
                z <= 1'b0;
            end
            S11: begin
                if (w) state <= S22;
                else state <= S21;
                z <= 1'b0;
            end
            S20: begin
                state <= B;
                z <= 1'b0;
            end
            S21: begin
                if (w) state <= C;
                else state <= B;
                z <= 1'b0;
            end
            S22: begin
                if (w) state <= B;
                else state <= C;
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
