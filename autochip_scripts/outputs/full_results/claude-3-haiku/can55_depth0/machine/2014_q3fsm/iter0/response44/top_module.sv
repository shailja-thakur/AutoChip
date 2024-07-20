module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] current_state, next_state;
parameter A = 4'd0, B = 4'd1, C = 4'd2, S10 = 4'd3, S11 = 4'd4, S20 = 4'd5, S21 = 4'd6, S22 = 4'd7;

always @(posedge clk or negedge reset) begin
    if (~reset) begin
        current_state <= A;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        A: begin
            if (s) begin
                next_state = B;
            end
            else begin
                next_state = current_state;
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
            next_state = A;
        end
    endcase
end

always @(current_state) begin
    case (current_state)
        S20: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
