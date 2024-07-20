module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

parameter WAIT = 2'b00;
parameter FIVE = 2'b01;
parameter SIX = 2'b10;
parameter ERR = 2'b11;

reg [1:0] state, next_state;
reg [2:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT;
        count <= 0;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            WAIT: begin
                if (in) begin
                    count <= 1;
                    next_state <= FIVE;
                end
                else begin
                    count <= 0;
                    next_state <= WAIT;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            FIVE: begin
                if (in) begin
                    count <= count + 1;
                    if (count == 4) begin
                        next_state <= SIX;
                    end
                    else begin
                        next_state <= FIVE;
                    end
                end
                else begin
                    count <= 0;
                    next_state <= WAIT;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            SIX: begin
                if (in) begin
                    next_state <= ERR;
                    disc <= 0;
                    flag <= 1;
                    err <= 0;
                end
                else begin
                    next_state <= WAIT;
                    disc <= 1;
                    flag <= 0;
                    err <= 0;
                end
                count <= 0;
            end
            ERR: begin
                if (in) begin
                    next_state <= ERR;
                    disc <= 0;
                    flag <= 0;
                    err <= 1;
                end
                else begin
                    next_state <= WAIT;
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                count <= 0;
            end
        endcase
    end
end

endmodule
