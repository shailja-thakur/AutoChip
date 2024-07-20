module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam IDLE = 2'b00;
localparam DETECT_FIVE = 2'b01;
localparam DETECT_SIX = 2'b10;
localparam ERROR = 2'b11;

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
                    next_state <= DETECT_FIVE;
                end
                else begin
                    count <= 0;
                    next_state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            DETECT_FIVE: begin
                if (in) begin
                    count <= count + 1;
                    if (count == 4) begin
                        next_state <= DETECT_SIX;
                    end
                    else begin
                        next_state <= DETECT_FIVE;
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
            DETECT_SIX: begin
                if (in) begin
                    if (in) begin
                        next_state <= ERROR;
                        disc <= 0;
                        flag <= 0;
                        err <= 1;
                    end
                    else begin
                        next_state <= IDLE;
                        disc <= 1;
                        flag <= 0;
                        err <= 0;
                    end
                end
                else begin
                    next_state <= IDLE;
                    disc <= 0;
                    flag <= 1;
                    err <= 0;
                end
                count <= 0;
            end
            ERROR: begin
                if (in) begin
                    next_state <= ERROR;
                end
                else begin
                    next_state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 1;
                count <= 0;
            end
            default: begin
                next_state <= IDLE;
                disc <= 0;
                flag <= 0;
                err <= 0;
                count <= 0;
            end
        endcase
    end
end

endmodule
