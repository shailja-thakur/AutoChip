module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

reg state;
parameter IDLE = 0, ACTIVE = 1;

always @(posedge clock) begin
    case (state)
        IDLE: begin
            if (a == 1'b0) begin
                p <= 1'b0;
                q <= 1'b0;
                state <= IDLE;
            end else begin
                p <= 1'b0;
                q <= 1'b0;
                state <= ACTIVE;
            end
        end
        ACTIVE: begin
            if (a == 1'b0) begin
                p <= 1'b0;
                q <= 1'b1;
                state <= IDLE;
            end else begin
                p <= 1'b1;
                q <= 1'b0;
                state <= ACTIVE;
            end
        end
        default: begin
            p <= 1'b0;
            q <= 1'b0;
            state <= IDLE;
        end
    endcase
end

endmodule
