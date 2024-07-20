module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state;
parameter A = 4'b0001, B = 4'b0010, C = 4'b0011, 
          S10 = 4'b0100, S11 = 4'b0101, S20 = 4'b0110, S21 = 4'b0111, S22 = 4'b1000;

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
        A: z = 1'b0;
        B: z = 1'b0;
        C: z = 1'b0;
        S10: z = 1'b0;
        S11: z = 1'b0;
        S20: z = 1'b0;
        S21: z = 1'b0;
        S22: z = 1'b0;
    endcase
end

endmodule
