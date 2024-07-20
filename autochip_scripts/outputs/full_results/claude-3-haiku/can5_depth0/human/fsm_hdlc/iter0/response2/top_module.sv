module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state;
parameter IDLE = 3'b000, DISCARD = 3'b001, FLAG = 3'b010, ERROR = 3'b011;

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
                disc <= 0;
                flag <= 0;
                err <= 0;
                if (in == 1'b1) begin
                    state <= DISCARD;
                end
                else begin
                    state <= IDLE;
                end
            end
            DISCARD: begin
                disc <= 1;
                flag <= 0;
                err <= 0;
                if (in == 1'b1) begin
                    state <= DISCARD;
                end
                else begin
                    state <= IDLE;
                end
            end
            FLAG: begin
                disc <= 0;
                flag <= 1;
                err <= 0;
                state <= IDLE;
            end
            ERROR: begin
                disc <= 0;
                flag <= 0;
                err <= 1;
                state <= IDLE;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

always @(posedge clk) begin
    case (state)
        IDLE: begin
            if (in == 1'b1) begin
                state <= DISCARD;
            end
            else begin
                state <= IDLE;
            end
        end
        DISCARD: begin
            if (in == 1'b0) begin
                state <= IDLE;
            end
            else if (in == 1'b1) begin
                state <= DISCARD;
            end
        end
        FLAG: begin
            state <= IDLE;
        end
        ERROR: begin
            state <= IDLE;
        end
        default: begin
            state <= IDLE;
        end
    endcase
end

endmodule
