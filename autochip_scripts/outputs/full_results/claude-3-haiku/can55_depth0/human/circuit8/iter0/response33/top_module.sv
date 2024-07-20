module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg state;
parameter WAIT = 1'b0, RISE = 1'b1;

always @(posedge clock) begin
    case (state)
        WAIT: begin
            if (a) begin
                state <= RISE;
                p <= 0;
                q <= 0;
            end
        end
        RISE: begin
            if (~a) begin
                state <= WAIT;
                p <= 0;
                q <= 1;
            end else begin
                p <= 1;
                q <= 0;
            end
        end
    endcase
end

endmodule
