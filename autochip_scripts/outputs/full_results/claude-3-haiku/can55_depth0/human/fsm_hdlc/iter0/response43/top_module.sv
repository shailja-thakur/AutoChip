module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'd0,
                 DISC = 3'd1,
                 FLAG = 3'd2,
                 ERR  = 3'd3;

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
                disc <= 0;
                flag <= 0;
                err <= 0;
                if (in) begin
                    count <= 1;
                end
                else begin
                    count <= 0;
                end
            end
            DISC: begin
                disc <= 1;
                count <= 0;
            end
            FLAG: begin
                flag <= 1;
                count <= 0;
            end
            ERR: begin
                err <= 1;
                count <= 0;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (in) begin
                if (count == 5) begin
                    next_state = DISC;
                end
                else begin
                    next_state = IDLE;
                end
            end
            else begin
                next_state = IDLE;
            end
        end
        DISC: begin
            next_state = IDLE;
        end
        FLAG: begin
            next_state = IDLE;
        end
        ERR: begin
            next_state = IDLE;
        end
    endcase
end

always @(posedge clk) begin
    if (reset) begin
        count <= 0;
    end
    else begin
        if (state == IDLE) begin
            if (in) begin
                count <= count + 1;
            end
            else begin
                count <= 0;
            end
        end
    end
end

endmodule
