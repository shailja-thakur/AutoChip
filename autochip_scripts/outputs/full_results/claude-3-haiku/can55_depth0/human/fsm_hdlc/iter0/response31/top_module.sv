module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

parameter IDLE = 2'b00, DETECTING = 2'b01, ERROR = 2'b10;
reg [1:0] state, next_state;
reg [2:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        count <= 0;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                if (in) begin
                    next_state <= DETECTING;
                    count <= 1;
                end
                else begin
                    next_state <= IDLE;
                    count <= 0;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            DETECTING: begin
                if (in) begin
                    count <= count + 1;
                    if (count == 3'b101) begin
                        next_state <= IDLE;
                        disc <= 1;
                        flag <= 0;
                        err <= 0;
                    end
                    else if (count == 3'b111) begin
                        next_state <= ERROR;
                        disc <= 0;
                        flag <= 0;
                        err <= 1;
                    end
                    else begin
                        next_state <= DETECTING;
                        disc <= 0;
                        flag <= 0;
                        err <= 0;
                    end
                end
                else begin
                    next_state <= IDLE;
                    count <= 0;
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            end
            ERROR: begin
                if (in) begin
                    next_state <= ERROR;
                    disc <= 0;
                    flag <= 0;
                    err <= 1;
                end
                else begin
                    next_state <= IDLE;
                    count <= 0;
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            end
            default: begin
                next_state <= IDLE;
                count <= 0;
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
        endcase
    end
end

endmodule
