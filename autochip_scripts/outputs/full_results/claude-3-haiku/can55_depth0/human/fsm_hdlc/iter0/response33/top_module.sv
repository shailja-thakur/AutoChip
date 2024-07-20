module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam IDLE = 3'b000;
localparam DISC = 3'b001;
localparam FLAG = 3'b010;
localparam ERR  = 3'b011;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    disc = 0;
    flag = 0;
    err = 0;

    case (state)
        IDLE: begin
            if (in) begin
                next_state = DISC;
            end
        end
        DISC: begin
            if (in) begin
                next_state = FLAG;
                disc = 1;
            end
            else begin
                next_state = IDLE;
            end
        end
        FLAG: begin
            if (in) begin
                next_state = ERR;
                flag = 1;
            end
            else begin
                next_state = IDLE;
            end
        end
        ERR: begin
            err = 1;
            if (!in) begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
