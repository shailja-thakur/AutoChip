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
            p <= 0;
            q <= 0;
            if (a) begin
                state <= 1'b1;
            end
        end
        1'b1: begin
            p <= 0;
            q <= 0;
            if (~a) begin
                state <= 1'b0;
            end else begin
                p <= 1;
            end
        end
    endcase
end

endmodule
