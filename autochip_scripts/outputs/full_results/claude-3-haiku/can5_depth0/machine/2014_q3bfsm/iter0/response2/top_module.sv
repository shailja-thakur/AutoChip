module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state, next_state;
parameter A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        A: begin
            if (x) begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
        end
        B: begin
            if (x) begin
                next_state = E;
            end
            else begin
                next_state = B;
            end
        end
        C: begin
            if (x) begin
                next_state = B;
            end
            else begin
                next_state = C;
            end
        end
        D: begin
            if (x) begin
                next_state = C;
            end
            else begin
                next_state = B;
            end
        end
        E: begin
            if (x) begin
                next_state = E;
            end
            else begin
                next_state = D;
            end
        end
    endcase
end

always @(*) begin
    case (state)
        D, E: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
