module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam [1:0] 
    WAIT = 2'b00,
    CONVERT = 2'b01,
    DONE = 2'b11;

reg [1:0] state, next_state;
reg [7:0] temp;
reg [3:0] count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WAIT;
        temp <= 8'b0;
        count <= 4'b0;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        if (state == CONVERT) begin
            temp <= {temp[6:0], x};
            count <= count + 1;
            if (count == 4'd8) begin
                z <= ~temp + 1;
                next_state <= DONE;
            end
        end
    end
end

always @(*) begin
    case (state)
        WAIT:
            if (!areset)
                next_state = CONVERT;
            else
                next_state = WAIT;
        CONVERT:
            if (count == 4'd8)
                next_state = DONE;
            else
                next_state = CONVERT;
        DONE:
            next_state = WAIT;
        default:
            next_state = WAIT;
    endcase
end

endmodule
