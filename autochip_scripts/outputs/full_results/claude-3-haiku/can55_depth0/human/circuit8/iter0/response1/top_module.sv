module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

reg state;
parameter WAIT = 1'b0, LATCH = 1'b1;

always @(posedge clock) begin
    case (state)
        WAIT: begin
            p <= 0;
            q <= 0;
            if (a == 1) begin
                state <= LATCH;
            end
        end
        LATCH: begin
            p <= 1;
            q <= a;
            if (a == 0) begin
                state <= WAIT;
            end
        end
    endcase
end

endmodule
