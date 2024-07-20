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
            if (a) begin
                state <= ACTIVE;
                p <= 0;
                q <= 0;
            end
            else begin
                state <= IDLE;
                p <= 0;
                q <= 0;
            end
        end
        ACTIVE: begin
            if (a) begin
                state <= ACTIVE;
                p <= 1;
                q <= 0;
            end
            else begin
                state <= IDLE;
                p <= 0;
                q <= 1;
            end
        end
        default: begin
            state <= IDLE;
            p <= 0;
            q <= 0;
        end
    endcase
end

endmodule
