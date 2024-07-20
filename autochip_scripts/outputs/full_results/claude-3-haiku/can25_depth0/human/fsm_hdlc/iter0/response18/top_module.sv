module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

parameter [2:0] IDLE = 3'b000, 
                DIS1 = 3'b001,
                DIS2 = 3'b010,
                FLAG = 3'b011,
                ERR  = 3'b100;

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
    next_state = state;
    disc = 0;
    flag = 0;
    err = 0;
    
    case (state)
        IDLE: begin
            if (in == 1'b1) begin
                next_state = DIS1;
            end
            else begin
                next_state = IDLE;
            end
        end
        DIS1: begin
            if (in == 1'b1) begin
                next_state = DIS2;
            end
            else begin
                next_state = IDLE;
            end
        end
        DIS2: begin
            if (in == 1'b1) begin
                next_state = DIS1;
                disc = 1;
            end
            else begin
                next_state = IDLE;
            end
        end
        FLAG: begin
            if (in == 1'b1) begin
                next_state = ERR;
            end
            else begin
                next_state = IDLE;
                flag = 1;
            end
        end
        ERR: begin
            if (in == 1'b1) begin
                next_state = ERR;
            end
            else begin
                next_state = IDLE;
            end
            err = 1;
        end
    endcase
end
endmodule
