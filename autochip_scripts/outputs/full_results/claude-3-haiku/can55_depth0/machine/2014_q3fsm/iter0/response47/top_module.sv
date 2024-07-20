module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [2:0] state, next_state;
parameter A = 3'd0, B = 3'd1, C = 3'd2, S10 = 3'd3, S11 = 3'd4, S20 = 3'd5, S21 = 3'd6, S22 = 3'd7;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        A: begin
            if (s) begin
                next_state = B;
            end else begin
                next_state = state;
            end
        end
        B: begin
            if (w) begin
                next_state = S11;
            end else begin
                next_state = S10;
            end
        end
        C: begin
            if (w) begin
                next_state = S11;
            end else begin
                next_state = S10;
            end
        end
        S10: begin
            if (w) begin
                next_state = S21;
            end else begin
                next_state = S20;
            end
        end
        S11: begin
            if (w) begin
                next_state = S22;
            end else begin
                next_state = S21;
            end
        end
        S20: begin
            next_state = B;
        end
        S21: begin
            if (w) begin
                next_state = C;
            end else begin
                next_state = B;
            end
        end
        S22: begin
            if (w) begin
                next_state = B;
            end else begin
                next_state = C;
            end
        end
        default: begin
            next_state = A;
        end
    endcase
end

always @(state) begin
    case (state)
        S20, S21, S22: begin
            z = 1'b1;
        end
        default: begin
            z = 1'b0;
        end
    endcase
end

endmodule
