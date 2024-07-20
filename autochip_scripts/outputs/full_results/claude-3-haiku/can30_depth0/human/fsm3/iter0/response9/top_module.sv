module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

localparam A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        A: begin
            if (in == 0) begin
                next_state = A;
                out = 0;
            end
            else begin
                next_state = B;
                out = 0;
            end
        end
        B: begin
            if (in == 0) begin
                next_state = C;
                out = 0;
            end
            else begin
                next_state = B;
                out = 0;
            end
        end
        C: begin
            if (in == 0) begin
                next_state = A;
                out = 0;
            end
            else begin
                next_state = D;
                out = 0;
            end
        end
        D: begin
            if (in == 0) begin
                next_state = C;
                out = 1;
            end
            else begin
                next_state = B;
                out = 1;
            end
        end
        default: begin
            next_state = A;
            out = 0;
        end
    endcase
end

endmodule
