module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg state; // 0 for reset, 1 for counting

always @(posedge clock) begin
    case (state)
        1'b0: begin // reset state
            p <= 0;
            q <= 0;
            if (a) begin
                state <= 1'b1; // transition to counting state
            end
        end
        1'b1: begin // counting state
            if (a) begin
                p <= 1;
            end else begin
                p <= 0;
            end
            q <= p;
            if (~a) begin
                state <= 1'b0; // transition back to reset state
            end
        end
    endcase
end

endmodule
