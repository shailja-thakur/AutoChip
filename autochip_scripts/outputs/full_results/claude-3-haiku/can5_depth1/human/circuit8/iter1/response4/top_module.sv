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
                p <= 1;
                q <= 0;
            end else begin
                p <= 0;
                q <= 1;
            end
        end
        1'b1: begin
            if (a) begin
                p <= 0;
                q <= 0;
            end else begin
                p <= 0;
                q <= 0;
            end
        end
    endcase

    state <= a;
end

endmodule
