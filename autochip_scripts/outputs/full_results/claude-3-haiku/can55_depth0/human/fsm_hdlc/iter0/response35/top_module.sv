module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state;
parameter IDLE = 3'b000, WAIT_1 = 3'b001, WAIT_5 = 3'b010, FLAG = 3'b011, ERROR = 3'b100;

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
                if (in == 1'b1) begin
                    state <= WAIT_1;
                end
                else begin
                    state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            WAIT_1: begin
                if (in == 1'b1) begin
                    state <= WAIT_5;
                end
                else begin
                    state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            WAIT_5: begin
                if (in == 1'b1) begin
                    if (in == 1'b1) begin
                        state <= FLAG;
                    end
                    else begin
                        state <= IDLE;
                    end
                end
                else begin
                    state <= IDLE;
                end
                disc <= 1;
                flag <= 0;
                err <= 0;
            end
            FLAG: begin
                if (in == 1'b1) begin
                    state <= ERROR;
                end
                else begin
                    state <= IDLE;
                end
                disc <= 0;
                flag <= 1;
                err <= 0;
            end
            ERROR: begin
                state <= ERROR;
                disc <= 0;
                flag <= 0;
                err <= 1;
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
