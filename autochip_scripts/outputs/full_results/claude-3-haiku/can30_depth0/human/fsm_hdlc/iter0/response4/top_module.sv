module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'd0,
                 DISCARD = 3'd1,
                 FLAG = 3'd2,
                 ERROR = 3'd3;

reg [2:0] state, next_state;
reg [2:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        count <= 3'd0;
        disc <= 1'b0;
        flag <= 1'b0;
        err <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                if (in) begin
                    count <= 3'd1;
                end
                else begin
                    count <= 3'd0;
                end
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b0;
            end
            DISCARD: begin
                if (in) begin
                    count <= count + 1'b1;
                    if (count == 3'd5) begin
                        next_state <= IDLE;
                        disc <= 1'b1;
                        count <= 3'd0;
                    end
                    else begin
                        next_state <= DISCARD;
                        disc <= 1'b0;
                    end
                end
                else begin
                    next_state <= IDLE;
                    disc <= 1'b0;
                    count <= 3'd0;
                end
                flag <= 1'b0;
                err <= 1'b0;
            end
            FLAG: begin
                if (in) begin
                    count <= count + 1'b1;
                    if (count == 3'd7) begin
                        next_state <= ERROR;
                        flag <= 1'b0;
                        err <= 1'b1;
                    end
                    else begin
                        next_state <= FLAG;
                        flag <= 1'b1;
                    end
                end
                else begin
                    next_state <= IDLE;
                    flag <= 1'b0;
                    err <= 1'b0;
                    count <= 3'd0;
                end
                disc <= 1'b0;
            end
            ERROR: begin
                if (in) begin
                    count <= count + 1'b1;
                    next_state <= ERROR;
                end
                else begin
                    next_state <= IDLE;
                    count <= 3'd0;
                end
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b1;
            end
            default: begin
                next_state <= IDLE;
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b0;
                count <= 3'd0;
            end
        endcase
    end
end

endmodule
