module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state;
parameter IDLE = 3'b000, DISC = 3'b001, FLAG = 3'b010, ERR = 3'b011;

always @(posedge clk or posedge reset) begin
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
                    state <= DISC;
                    disc <= 1;
                end
                else begin
                    state <= IDLE;
                    disc <= 0;
                end
                flag <= 0;
                err <= 0;
            end
            DISC: begin
                if (in) begin
                    state <= ERR;
                    err <= 1;
                end
                else begin
                    state <= IDLE;
                    disc <= 0;
                end
                flag <= 0;
            end
            FLAG: begin
                if (in) begin
                    state <= ERR;
                    err <= 1;
                end
                else begin
                    state <= IDLE;
                    flag <= 0;
                end
                disc <= 0;
            end
            ERR: begin
                if (in) begin
                    state <= ERR;
                    err <= 1;
                end
                else begin
                    state <= IDLE;
                    err <= 0;
                end
                disc <= 0;
                flag <= 0;
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
