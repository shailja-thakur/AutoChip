module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

parameter ZERO = 2'b00, ONE = 2'b01, ERROR = 2'b11;

reg [1:0] state, next_state;
reg [2:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= ZERO;
        count <= 0;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            ZERO: begin
                if (in == 1'b0) begin
                    count <= 0;
                end
                else begin
                    count <= count + 1;
                    if (count == 3'd5) begin
                        next_state <= ONE;
                    end
                    else begin
                        next_state <= ZERO;
                    end
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            ONE: begin
                if (in == 1'b0) begin
                    next_state <= ZERO;
                    count <= 0;
                    disc <= 1;
                    flag <= 0;
                    err <= 0;
                end
                else begin
                    count <= count + 1;
                    if (count == 3'd6) begin
                        next_state <= ONE;
                        disc <= 0;
                        flag <= 1;
                        err <= 0;
                    end
                    else if (count == 3'd7) begin
                        next_state <= ERROR;
                        disc <= 0;
                        flag <= 0;
                        err <= 1;
                    end
                    else begin
                        next_state <= ONE;
                        disc <= 0;
                        flag <= 0;
                        err <= 0;
                    end
                end
            end
            ERROR: begin
                next_state <= ERROR;
                disc <= 0;
                flag <= 0;
                err <= 1;
            end
            default: begin
                next_state <= ZERO;
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
        endcase
    end
end

endmodule
