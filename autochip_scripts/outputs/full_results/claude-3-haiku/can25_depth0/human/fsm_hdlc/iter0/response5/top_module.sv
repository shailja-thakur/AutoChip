module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'b000, 
                 FIVE_ONE = 3'b001, 
                 SIX_ONE = 3'b010, 
                 SEVEN_ONE = 3'b011;

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
    err = 1'b0;

    case (state)
        IDLE: begin
            if (in == 1'b0) begin
                next_state = IDLE;
            end
            else begin
                next_state = FIVE_ONE;
            end
        end
        FIVE_ONE: begin
            if (in == 1'b0) begin
                next_state = IDLE;
            end
            else begin
                next_state = SIX_ONE;
            end
        end
        SIX_ONE: begin
            if (in == 1'b0) begin
                next_state = IDLE;
                disc = 1'b1;
            end
            else begin
                next_state = SEVEN_ONE;
                flag = 1'b1;
            end
        end
        SEVEN_ONE: begin
            if (in == 1'b0) begin
                next_state = IDLE;
            end
            else begin
                next_state = SEVEN_ONE;
                err = 1'b1;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
