module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    localparam [2:0] A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;
    reg [2:0] state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            A: begin
                if (w == 1'b0) begin
                    next_state = B;
                end
                else begin
                    next_state = A;
                end
            end
            B: begin
                if (w == 1'b0) begin
                    next_state = C;
                end
                else begin
                    next_state = D;
                end
            end
            C: begin
                if (w == 1'b0) begin
                    next_state = E;
                end
                else begin
                    next_state = D;
                end
            end
            D: begin
                if (w == 1'b0) begin
                    next_state = F;
                end
                else begin
                    next_state = A;
                end
            end
            E: begin
                if (w == 1'b0) begin
                    next_state = E;
                end
                else begin
                    next_state = D;
                end
            end
            F: begin
                if (w == 1'b0) begin
                    next_state = C;
                end
                else begin
                    next_state = D;
                end
            end
            default: begin
                next_state = A;
            end
        endcase
    end

    always @(*) begin
        case (state)
            E, F: begin
                z = 1'b1;
            end
            default: begin
                z = 1'b0;
            end
        endcase
    end

endmodule
