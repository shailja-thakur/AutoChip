module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

parameter IDLE = 2'b00;
parameter DETECT_FLAG = 2'b01;
parameter DETECT_ERR = 2'b10;

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
            DETECT_FLAG: begin
                if (in) begin
                    count <= count + 1;
                    if (count == 6) begin
                        flag <= 1;
                        count <= 0;
                    end
                    else begin
                        flag <= 0;
                    end
                    disc <= 0;
                    err <= 0;
                end
                else begin
                    count <= 0;
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            end
            DETECT_ERR: begin
                if (in) begin
                    count <= count + 1;
                    if (count == 7) begin
                        err <= 1;
                        count <= 0;
                    end
                    else begin
                        err <= 0;
                    end
                    disc <= 0;
                    flag <= 0;
                end
                else begin
                    count <= 0;
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (in) begin
                next_state = DETECT_FLAG;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_FLAG: begin
            if (in && count == 5) begin
                next_state = DETECT_ERR;
            end
            else if (in) begin
                next_state = DETECT_FLAG;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_ERR: begin
            if (in) begin
                next_state = DETECT_ERR;
            end
            else begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
