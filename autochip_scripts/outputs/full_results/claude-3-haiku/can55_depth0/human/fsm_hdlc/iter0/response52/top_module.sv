module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state;
parameter IDLE = 3'b000, DISCARD = 3'b001, FLAG = 3'b010, ERR = 3'b011;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in) begin
                    state <= DISCARD;
                    disc <= 1;
                end
                else begin
                    state <= IDLE;
                    disc <= 0;
                end
                flag <= 0;
                err <= 0;
            end
            DISCARD: begin
                if (in) begin
                    if (state == DISCARD) begin
                        state <= FLAG;
                        disc <= 0;
                        flag <= 1;
                    end
                    else begin
                        state <= ERR;
                        disc <= 0;
                        flag <= 0;
                        err <= 1;
                    end
                end
                else begin
                    state <= IDLE;
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            end
            FLAG: begin
                if (in) begin
                    state <= ERR;
                    disc <= 0;
                    flag <= 0;
                    err <= 1;
                end
                else begin
                    state <= IDLE;
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            end
            ERR: begin
                if (in) begin
                    state <= ERR;
                    disc <= 0;
                    flag <= 0;
                    err <= 1;
                end
                else begin
                    state <= IDLE;
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            end
            default: begin
                state <= IDLE;
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
        endcase
    end
end

endmodule
