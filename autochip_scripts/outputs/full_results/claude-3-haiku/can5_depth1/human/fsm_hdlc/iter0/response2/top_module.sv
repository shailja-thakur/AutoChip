module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] WAIT = 3'b000,
                 CHECK_5 = 3'b001,
                 DETECT_FLAG = 3'b010,
                 DETECT_ERR = 3'b011;

reg [2:0] state, next_state;
reg [2:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT;
        count <= 0;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            WAIT: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
                if (in) begin
                    count <= 1;
                    next_state <= CHECK_5;
                end
                else begin
                    count <= 0;
                    next_state <= WAIT;
                end
            end
            CHECK_5: begin
                if (in) begin
                    count <= count + 1;
                    if (count == 3'd5) begin
                        if (in) begin
                            disc <= 1;
                            count <= 0;
                            next_state <= WAIT;
                        end
                        else begin
                            count <= 0;
                            next_state <= DETECT_FLAG;
                        end
                    end
                    else begin
                        next_state <= CHECK_5;
                    end
                end
                else begin
                    count <= 0;
                    next_state <= WAIT;
                end
            end
            DETECT_FLAG: begin
                if (in) begin
                    flag <= 1;
                    next_state <= WAIT;
                end
                else begin
                    next_state <= WAIT;
                end
            end
            DETECT_ERR: begin
                err <= 1;
                next_state <= WAIT;
            end
            default: begin
                next_state <= WAIT;
            end
        endcase
    end
end

always @* begin
    case (state)
        WAIT: begin
            if (in) begin
                next_state <= CHECK_5;
            end
            else begin
                next_state <= WAIT;
            end
        end
        CHECK_5: begin
            if (in) begin
                if (count == 3'd6) begin
                    next_state <= DETECT_ERR;
                end
                else begin
                    next_state <= CHECK_5;
                end
            end
            else begin
                next_state <= WAIT;
            end
        end
        DETECT_FLAG: begin
            if (in) begin
                next_state <= DETECT_ERR;
            end
            else begin
                next_state <= WAIT;
            end
        end
        DETECT_ERR: begin
            next_state <= WAIT;
        end
        default: begin
            next_state <= WAIT;
        end
    endcase
end

endmodule
