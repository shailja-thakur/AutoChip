module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'b000,
                 DISC = 3'b001,
                 FLAG = 3'b010,
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
            DISC: begin
                if (in) begin
                    count <= count + 1;
                    if (count == 3'b110) begin
                        next_state <= IDLE;
                        disc <= 1;
                    end
                    else begin
                        next_state <= DISC;
                    end
                end
                else begin
                    count <= 0;
                    next_state <= IDLE;
                    disc <= 0;
                end
                flag <= 0;
                err <= 0;
            end
            FLAG: begin
                if (in) begin
                    count <= count + 1;
                    if (count == 3'b111) begin
                        next_state <= ERROR;
                        err <= 1;
                    end
                    else begin
                        next_state <= FLAG;
                    end
                end
                else begin
                    count <= 0;
                    next_state <= IDLE;
                    flag <= 1;
                end
                disc <= 0;
                err <= 0;
            end
            ERROR: begin
                if (in) begin
                    count <= count + 1;
                    next_state <= ERROR;
                end
                else begin
                    count <= 0;
                    next_state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 1;
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
