module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    parameter A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;
    reg [2:0] state, next_state;

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
                if (w) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
                z = 1'b0;
            end
            B: begin
                if (w) begin
                    next_state = D;
                end else begin
                    next_state = C;
                end
                z = 1'b0;
            end
            C: begin
                if (w) begin
                    next_state = D;
                end else begin
                    next_state = E;
                end
                z = 1'b0;
            end
            D: begin
                if (w) begin
                    next_state = A;
                end else begin
                    next_state = F;
                end
                z = 1'b0;
            end
            E: begin
                if (w) begin
                    next_state = D;
                end else begin
                    next_state = E;
                end
                z = 1'b1;
            end
            F: begin
                if (w) begin
                    next_state = D;
                end else begin
                    next_state = C;
                end
                z = 1'b1;
            end
            default: begin
                next_state = A;
                z = 1'b0;
            end
        endcase
    end

endmodule
