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
    end
    else begin
        state <= next_state;
        count <= in ? (count + 1) : 0;
    end
end

always @(*) begin
    disc = 0;
    flag = 0;
    err = 0;

    case (state)
        IDLE: begin
            if (in && count == 4) begin
                next_state = DISC;
            end
            else if (in && count == 5) begin
                next_state = FLAG;
            end
            else if (in && count == 6) begin
                next_state = ERR;
            end
            else begin
                next_state = IDLE;
            end
        end
        DISC: begin
            disc = 1;
            next_state = IDLE;
        end
        FLAG: begin
            flag = 1;
            next_state = IDLE;
        end
        ERR: begin
            err = 1;
            next_state = IDLE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
