module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'b000, 
                 DETECT_FLAG = 3'b001,
                 DETECT_DISC = 3'b010,
                 DETECT_ERROR = 3'b011;

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
                    end
                    else begin
                        flag <= 0;
                    end
                end
                else begin
                    count <= 0;
                    flag <= 0;
                end
                disc <= 0;
                err <= 0;
            end
            DETECT_DISC: begin
                if (in) begin
                    count <= count + 1;
                    if (count == 5) begin
                        disc <= 1;
                        count <= 0;
                    end
                    else begin
                        disc <= 0;
                    end
                end
                else begin
                    count <= 0;
                    disc <= 0;
                end
                flag <= 0;
                err <= 0;
            end
            DETECT_ERROR: begin
                if (in) begin
                    count <= count + 1;
                    if (count == 7) begin
                        err <= 1;
                    end
                    else begin
                        err <= 0;
                    end
                end
                else begin
                    count <= 0;
                    err <= 0;
                end
                disc <= 0;
                flag <= 0;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (in) begin
                next_state = DETECT_ERROR;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_FLAG: begin
            if (in) begin
                next_state = DETECT_FLAG;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_DISC: begin
            if (in) begin
                next_state = DETECT_FLAG;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_ERROR: begin
            if (in) begin
                next_state = DETECT_ERROR;
            end
            else begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
