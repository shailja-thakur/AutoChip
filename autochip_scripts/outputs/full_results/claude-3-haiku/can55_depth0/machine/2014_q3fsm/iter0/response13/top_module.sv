module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [2:0] current_state, next_state;

parameter A = 3'b000, B = 3'b001, C = 3'b010, S10 = 3'b011, S11 = 3'b100, S20 = 3'b101, S21 = 3'b110, S22 = 3'b111;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= A;
    end else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        A: begin
            if (s) begin
                next_state = B;
            end else begin
                next_state = current_state;
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
            next_state = current_state;
        end
    endcase
end

always @(current_state) begin
    case (current_state)
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
