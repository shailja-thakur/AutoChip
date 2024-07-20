module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state, next_state;

parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @* begin
    case (state)
        A: begin
            if (w) begin
                next_state = A;
                z = 0;
            end else begin
                next_state = B;
                z = 0;
            end
        end

        B: begin
            if (w) begin
                next_state = D;
                z = 0;
            end else begin
                next_state = C;
                z = 0;
            end
        end

        C: begin
            if (w) begin
                next_state = D;
                z = 0;
            end else begin
                next_state = E;
                z = 0;
            end
        end

        D: begin
            if (w) begin
                next_state = A;
                z = 0;
            end else begin
                next_state = F;
                z = 0;
            end
        end

        E: begin
            if (w) begin
                next_state = D;
                z = 0;
            end else begin
                next_state = E;
                z = 1;
            end
        end

        F: begin
            if (w) begin
                next_state = D;
                z = 0;
            end else begin
                next_state = C;
                z = 1;
            end
        end

        default: begin
            next_state = A;
            z = 0;
        end
    endcase
end

endmodule
