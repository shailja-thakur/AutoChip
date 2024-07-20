module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [4:0] state;
parameter A = 5'b00001, B = 5'b00010, C = 5'b00100, S10 = 5'b01000, S11 = 5'b10000, S20 = 5'b00101, S21 = 5'b00110, S22 = 5'b00111;

always @(posedge clk or posedge reset) begin
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
                    state <= A;
                end
                z <= 0;
            end
            B: begin
                if (w) begin
                    state <= S11;
                end
                else begin
                    state <= S10;
                end
                z <= 0;
            end
            C: begin
                if (w) begin
                    state <= S11;
                end
                else begin
                    state <= S10;
                end
                z <= 0;
            end
            S10: begin
                if (w) begin
                    state <= S21;
                end
                else begin
                    state <= S20;
                end
                z <= 0;
            end
            S11: begin
                if (w) begin
                    state <= S22;
                end
                else begin
                    state <= S21;
                end
                z <= 0;
            end
            S20: begin
                state <= B;
                z <= 0;
            end
            S21: begin
                if (w) begin
                    state <= C;
                end
                else begin
                    state <= B;
                end
                z <= 0;
            end
            S22: begin
                if (w) begin
                    state <= B;
                end
                else begin
                    state <= C;
                end
                z <= 0;
            end
        endcase
    end
end

endmodule
