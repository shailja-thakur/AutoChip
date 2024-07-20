module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;
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
                z = 0;
                if (w) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
            B: begin
                z = 0;
                if (w) begin
                    next_state = D;
                end else begin
                    next_state = C;
                end
            end
            C: begin
                z = 0;
                if (w) begin
                    next_state = D;
                end else begin
                    next_state = E;
                end
            end
            D: begin
                z = 0;
                if (w) begin
                    next_state = A;
                end else begin
                    next_state = F;
                end
            end
            E: begin
                z = 1;
                if (w) begin
                    next_state = D;
                end else begin
                    next_state = E;
                end
            end
            F: begin
                z = 1;
                if (w) begin
                    next_state = D;
                end else begin
                    next_state = C;
                end
            end
            default: begin
                z = 0;
                next_state = A;
            end
        endcase
    end

endmodule
