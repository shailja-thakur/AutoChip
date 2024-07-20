module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [4:0] state, next_state;
parameter A = 5'd0, B = 5'd1, C = 5'd2, S10 = 5'd3, S11 = 5'd4, S20 = 5'd5, S21 = 5'd6, S22 = 5'd7;

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
        A: begin
            z = 1'b0;
        end
        B: begin
            z = 1'b0;
        end
        C: begin
            z = 1'b0;
        end
        S10: begin
            z = 1'b0;
        end
        S11: begin
            z = 1'b0;
        end
        S20: begin
            z = 1'b0;
        end
        S21: begin
            z = 1'b0;
        end
        S22: begin
            z = 1'b0;
        end
        default: begin
            z = 1'b0;
        end
    endcase
end

endmodule
