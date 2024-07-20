module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [4:0] state, next_state;
parameter A = 5'b00001, B = 5'b00010, C = 5'b00100, S10 = 5'b01000, S11 = 5'b10000, S20 = 5'b00101, S21 = 5'b00110, S22 = 5'b00111;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        A: begin
            if (s) begin
                next_state = B;
            end
            else begin
                next_state = state;
            end
        end
        B: begin
            if (w) begin
                next_state = S11;
            end
            else begin
                next_state = S10;
            end
        end
        C: begin
            if (w) begin
                next_state = S11;
            end
            else begin
                next_state = S10;
            end
        end
        S10: begin
            if (w) begin
                next_state = S21;
            end
            else begin
                next_state = S20;
            end
        end
        S11: begin
            if (w) begin
                next_state = S22;
            end
            else begin
                next_state = S21;
            end
        end
        S20: begin
            next_state = B;
        end
        S21: begin
            if (w) begin
                next_state = C;
            end
            else begin
                next_state = B;
            end
        end
        S22: begin
            if (w) begin
                next_state = B;
            end
            else begin
                next_state = C;
            end
        end
        default: begin
            next_state = state;
        end
    endcase
end

always @(state) begin
    case (state)
        A: z = 0;
        B: z = 0;
        C: z = 0;
        S10: z = 0;
        S11: z = 0;
        S20: z = 0;
        S21: z = 0;
        S22: z = 0;
        default: z = 0;
    endcase
end

endmodule
