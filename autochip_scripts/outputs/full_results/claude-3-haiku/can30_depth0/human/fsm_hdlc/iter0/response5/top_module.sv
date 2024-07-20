module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

parameter IDLE = 3'b000;
parameter DISC = 3'b001;
parameter FLAG = 3'b010;
parameter ERR  = 3'b011;

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
                end
                else begin
                    count <= 0;
                end
                disc <= 1;
                flag <= 0;
                err <= 0;
            end
            FLAG: begin
                count <= 0;
                disc <= 0;
                flag <= 1;
                err <= 0;
            end
            ERR: begin
                count <= count + 1;
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
            if (in) begin
                next_state = DISC;
            end
            else begin
                next_state = IDLE;
            end
        end
        DISC: begin
            if (in && count == 4) begin
                next_state = FLAG;
            end
            else if (in && count == 6) begin
                next_state = ERR;
            end
            else if (!in) begin
                next_state = IDLE;
            end
            else begin
                next_state = DISC;
            end
        end
        FLAG: begin
            if (in) begin
                next_state = DISC;
            end
            else begin
                next_state = IDLE;
            end
        end
        ERR: begin
            if (!in) begin
                next_state = IDLE;
            end
            else begin
                next_state = ERR;
            end
        end
    endcase
end

endmodule
