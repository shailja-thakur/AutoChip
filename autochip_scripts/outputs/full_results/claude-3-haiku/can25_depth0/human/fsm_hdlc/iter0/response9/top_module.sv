module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'b000,
                 DISCCARD = 3'b001,
                 DETECT_FLAG = 3'b010,
                 ERROR = 3'b011;

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
        count <= (in) ? count + 1 : 0;
        case (state)
            IDLE: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            DISCCARD: begin
                disc <= 1;
                flag <= 0;
                err <= 0;
            end
            DETECT_FLAG: begin
                disc <= 0;
                flag <= 1;
                err <= 0;
            end
            ERROR: begin
                disc <= 0;
                flag <= 0;
                err <= 1;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (in && count == 5) next_state = DISCCARD;
            else if (in && count == 6) next_state = DETECT_FLAG;
            else if (in && count >= 7) next_state = ERROR;
            else next_state = IDLE;
        end
        DISCCARD: begin
            if (!in) next_state = IDLE;
            else next_state = DISCCARD;
        end
        DETECT_FLAG: begin
            if (!in) next_state = IDLE;
            else next_state = DETECT_FLAG;
        end
        ERROR: begin
            if (!in) next_state = IDLE;
            else next_state = ERROR;
        end
    endcase
end

endmodule
