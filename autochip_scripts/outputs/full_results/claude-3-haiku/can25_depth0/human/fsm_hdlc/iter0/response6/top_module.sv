module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

parameter IDLE = 2'b00;
parameter DISCARD = 2'b01;
parameter FLAG = 2'b10;
parameter ERROR = 2'b11;

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
                    count <= 1;
                end
                else begin
                    count <= 0;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            DISCARD: begin
                if (in) begin
                    count <= count + 1;
                    if (count == 6) begin
                        next_state <= IDLE;
                        disc <= 1;
                    end
                    else begin
                        next_state <= DISCARD;
                        disc <= 0;
                    end
                end
                else begin
                    next_state <= IDLE;
                    count <= 0;
                    disc <= 0;
                end
                flag <= 0;
                err <= 0;
            end
            FLAG: begin
                if (in) begin
                    count <= count + 1;
                    if (count == 7) begin
                        next_state <= ERROR;
                        flag <= 0;
                        err <= 1;
                    end
                    else begin
                        next_state <= FLAG;
                        flag <= 1;
                    end
                end
                else begin
                    next_state <= IDLE;
                    count <= 0;
                    flag <= 0;
                    err <= 0;
                end
                disc <= 0;
            end
            ERROR: begin
                if (in) begin
                    count <= count + 1;
                    next_state <= ERROR;
                end
                else begin
                    next_state <= IDLE;
                    count <= 0;
                end
                disc <= 0;
                flag <= 0;
                err <= 1;
            end
        endcase
    end
end

endmodule
