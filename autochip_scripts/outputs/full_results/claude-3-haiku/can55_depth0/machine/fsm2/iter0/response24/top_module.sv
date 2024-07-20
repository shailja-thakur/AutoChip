module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state;
parameter A = 1'b0, B = 1'b1;

always @(*) begin
    case (state)
        A: begin
            if (j) begin
                state = B;
            end else begin
                state = A;
            end
        end
        B: begin
            if (k) begin
                state = A;
            end else begin
                state = B;
            end
        end
        default: state = A;
    endcase
end

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= state;
    end
end

always @(*) begin
    if (state == B) begin
        out = 1'b1;
    end else begin
        out = 1'b0;
    end
end

endmodule
