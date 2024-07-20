module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg state;
parameter IDLE = 1'b0, ACTIVE = 1'b1;

always @(posedge clock) begin
    case (state)
        IDLE: begin
            p <= 0;
            q <= 0;
            if (a) begin
                state <= ACTIVE;
            end
        end
        ACTIVE: begin
            if (a) begin
                p <= 1;
            end else begin
                p <= 0;
            end
            q <= p;
            if (~a) begin
                state <= IDLE;
            end
        end
        default: begin
            state <= IDLE;
        end
    endcase
end

endmodule
