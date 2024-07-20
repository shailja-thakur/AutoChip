module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

localparam [1:0] A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;
reg [1:0] state, next_state;

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
            if (in) begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
        end
        B: begin
            if (in) begin
                next_state = B;
            end
            else begin
                next_state = C;
            end
        end
        C: begin
            if (in) begin
                next_state = D;
            end
            else begin
                next_state = A;
            end
        end
        D: begin
            if (in) begin
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

always @(*) begin
    if (state == D) begin
        out = 1'b1;
    end
    else begin
        out = 1'b0;
    end
end

endmodule
