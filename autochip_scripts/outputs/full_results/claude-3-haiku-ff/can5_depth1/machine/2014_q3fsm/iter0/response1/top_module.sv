module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [4:0] state;
parameter [4:0] A = 5'b00001,
                B = 5'b00010,
                C = 5'b00011,
                S10 = 5'b00100,
                S11 = 5'b00101,
                S20 = 5'b00110,
                S21 = 5'b00111,
                S22 = 5'b01000;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
        z <= 0;
    end
    else begin
        case (state)
            A: begin
                if (s)
                    state <= B;
                else
                    state <= state;
                z <= 0;
            end
            B: begin
                if (w)
                    state <= S11;
                else
                    state <= S10;
                z <= 0;
            end
            C: begin
                if (w)
                    state <= S11;
                else
                    state <= S10;
                z <= 0;
            end
            S10: begin
                if (w)
                    state <= S21;
                else
                    state <= S20;
                z <= 0;
            end
            S11: begin
                if (w)
                    state <= S22;
                else
                    state <= S21;
                z <= 0;
            end
            S20: begin
                state <= B;
                z <= 0;
            end
            S21: begin
                if (w)
                    state <= C;
                else
                    state <= B;
                z <= 0;
            end
            S22: begin
                if (w)
                    state <= B;
                else
                    state <= C;
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
