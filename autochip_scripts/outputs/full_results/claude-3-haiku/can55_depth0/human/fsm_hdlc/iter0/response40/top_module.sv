module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    parameter IDLE = 3'b000;
    parameter WAIT_ZERO = 3'b001;
    parameter FLAG = 3'b010;
    parameter ERROR = 3'b011;
    parameter DISCARD = 3'b100;

    reg [2:0] state, next_state;
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
                        count <= 1;
                        next_state <= WAIT_ZERO;
                    end
                    else begin
                        count <= 0;
                        next_state <= IDLE;
                    end
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                WAIT_ZERO: begin
                    if (in) begin
                        count <= count + 1;
                        if (count == 5) begin
                            next_state <= FLAG;
                        end
                        else if (count == 6) begin
                            next_state <= ERROR;
                        end
                        else begin
                            next_state <= WAIT_ZERO;
                        end
                    end
                    else begin
                        count <= 0;
                        next_state <= IDLE;
                    end
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                FLAG: begin
                    next_state <= IDLE;
                    disc <= 0;
                    flag <= 1;
                    err <= 0;
                end
                ERROR: begin
                    next_state <= IDLE;
                    disc <= 0;
                    flag <= 0;
                    err <= 1;
                end
                DISCARD: begin
                    next_state <= IDLE;
                    disc <= 1;
                    flag <= 0;
                    err <= 0;
                end
                default: begin
                    next_state <= IDLE;
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            endcase
        end
    end
endmodule
