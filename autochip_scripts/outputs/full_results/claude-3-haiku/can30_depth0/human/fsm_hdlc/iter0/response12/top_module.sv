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
                ERR = 3'b011;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    disc = 0;
    flag = 0;
    err = 0;
    
    case (state)
        IDLE: begin
            if (in) begin
                next_state = DISC;
            end else begin
                next_state = IDLE;
            end
        end
        
        DISC: begin
            disc = 1;
            if (in) begin
                next_state = FLAG;
            end else begin
                next_state = IDLE;
            end
        end
        
        FLAG: begin
            flag = 1;
            if (in) begin
                next_state = ERR;
            end else begin
                next_state = IDLE;
            end
        end
        
        ERR: begin
            err = 1;
            if (in) begin
                next_state = ERR;
            end else begin
                next_state = IDLE;
            end
        end
        
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
