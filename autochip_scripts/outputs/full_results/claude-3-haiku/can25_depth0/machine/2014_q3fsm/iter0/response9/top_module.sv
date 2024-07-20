module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state, next_state;
parameter A = 4'b0001, B = 4'b0010, C = 4'b0011, 
          S10 = 4'b0100, S11 = 4'b0101, S20 = 4'b0110, 
          S21 = 4'b0111, S22 = 4'b1000;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        A: begin
            if (s) next_state = B;
            else next_state = state;
        end
        B: begin
            if (w) next_state = S11;
            else next_state = S10;
        end
        C: begin
            if (w) next_state = S11;
            else next_state = S10;
        end
        S10: begin
            if (w) next_state = S21;
            else next_state = S20;
        end
        S11: begin
            if (w) next_state = S22;
            else next_state = S21;
        end
        S20: begin
            next_state = B;
        end
        S21: begin
            if (w) next_state = C;
            else next_state = B;
        end
        S22: begin
            if (w) next_state = B;
            else next_state = C;
        end
        default: next_state = A;
    endcase
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        z <= 0;
    end else begin
        case (state)
            S20, S21, S22: z <= 1;
            default: z <= 0;
        endcase
    end
end

endmodule
