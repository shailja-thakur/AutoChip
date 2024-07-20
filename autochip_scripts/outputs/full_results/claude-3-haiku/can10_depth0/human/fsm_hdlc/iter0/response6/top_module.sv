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
                 ERR  = 3'b011;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err  = 1'b0;
    case (state)
        IDLE: begin
            if (in == 1'b1) begin
                next_state = DISC;
            end
            else begin
                next_state = IDLE;
            end
        end
        DISC: begin
            disc = 1'b1;
            if (in == 1'b1) begin
                next_state = DISC;
            end
            else begin
                next_state = IDLE;
            end
        end
        FLAG: begin
            flag = 1'b1;
            if (in == 1'b1) begin
                next_state = ERR;
            end
            else begin
                next_state = IDLE;
            end
        end
        ERR: begin
            err = 1'b1;
            if (in == 1'b1) begin
                next_state = ERR;
            end
            else begin
                next_state = IDLE;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
