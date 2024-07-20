module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

parameter WAIT = 3'b000;
parameter DISC = 3'b001;
parameter FLAG = 3'b010;
parameter ERR  = 3'b011;

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
                if (in) begin
                    count <= count + 1;
                end
                else begin
                    count <= 0;
                end
                disc <= 0;
                flag <= 1;
                err <= 0;
            end
            ERR: begin
                if (in) begin
                    count <= count + 1;
                end
                else begin
                    count <= 0;
                end
                disc <= 0;
                flag <= 0;
                err <= 1;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        WAIT: begin
            if (in) begin
                if (count == 5) begin
                    next_state = DISC;
                end
                else begin
                    next_state = WAIT;
                end
            end
            else begin
                next_state = WAIT;
            end
        end
        DISC: begin
            if (in) begin
                if (count == 6) begin
                    next_state = FLAG;
                end
                else begin
                    next_state = DISC;
                end
            end
            else begin
                next_state = WAIT;
            end
        end
        FLAG: begin
            if (in) begin
                if (count == 7) begin
                    next_state = ERR;
                end
                else begin
                    next_state = FLAG;
                end
            end
            else begin
                next_state = WAIT;
            end
        end
        ERR: begin
            if (in) begin
                next_state = ERR;
            end
            else begin
                next_state = WAIT;
            end
        end
        default: begin
            next_state = WAIT;
        end
    endcase
end

endmodule
