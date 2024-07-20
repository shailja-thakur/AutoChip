module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= 'A;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        'A: begin
            if (s) begin
                next_state = 'B;
            end else begin
                next_state = state;
            end
        end
        'B: begin
            if (w) begin
                next_state = 'S11;
            end else begin
                next_state = 'S10;
            end
        end
        'C: begin
            if (w) begin
                next_state = 'S11;
            end else begin
                next_state = 'S10;
            end
        end
        'S10: begin
            if (w) begin
                next_state = 'S21;
            end else begin
                next_state = 'S20;
            end
        end
        'S11: begin
            if (w) begin
                next_state = 'S22;
            end else begin
                next_state = 'S21;
            end
        end
        'S20: begin
            next_state = 'B;
        end
        'S21: begin
            if (w) begin
                next_state = 'C;
            end else begin
                next_state = 'B;
            end
        end
        'S22: begin
            if (w) begin
                next_state = 'B;
            end else begin
                next_state = 'C;
            end
        end
    endcase
end

always @(state) begin
    case (state)
        'A: z = 1'b0;
        'B: z = 1'b0;
        'C: z = 1'b0;
        'S10: z = 1'b0;
        'S11: z = 1'b1;
        'S20: z = 1'b0;
        'S21: z = 1'b1;
        'S22: z = 1'b1;
    endcase
end

endmodule
