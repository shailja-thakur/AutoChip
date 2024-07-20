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

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            disc = 0;
            flag = 0;
            err = 0;
            if (in == 1) begin
                next_state = DISC;
            end
            else begin
                next_state = IDLE;
            end
        end
        DISC: begin
            disc = 1;
            flag = 0;
            err = 0;
            if (in == 0) begin
                next_state = IDLE;
            end
            else begin
                next_state = DISC;
            end
        end
        FLAG: begin
            disc = 0;
            flag = 1;
            err = 0;
            next_state = IDLE;
        end
        ERR: begin
            disc = 0;
            flag = 0;
            err = 1;
            next_state = IDLE;
        end
        default: begin
            disc = 0;
            flag = 0;
            err = 0;
            next_state = IDLE;
        end
    endcase
end

always @(*) begin
    case (state)
        IDLE: begin
            if (in == 1) begin
                next_state = DISC;
            end
            else begin
                next_state = IDLE;
            end
        end
        DISC: begin
            if (in == 0) begin
                next_state = IDLE;
            end
            else begin
                next_state = DISC;
            end
        end
        FLAG: begin
            next_state = IDLE;
        end
        ERR: begin
            next_state = IDLE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
