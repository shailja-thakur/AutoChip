module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg state;

always @(posedge clock) begin
    case (state)
        1'b0: begin
            if (a) begin
                p <= 1'b1;
                q <= 1'b0;
                state <= 1'b1;
            end else begin
                p <= 1'b0;
                q <= 1'b0;
                state <= 1'b0;
            end
        end
        1'b1: begin
            p <= 1'b1;
            q <= 1'b1;
            state <= 1'b0;
        end
    endcase
end

endmodule
