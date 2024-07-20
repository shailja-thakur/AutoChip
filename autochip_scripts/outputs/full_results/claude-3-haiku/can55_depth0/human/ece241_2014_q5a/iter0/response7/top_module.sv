module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] result;
reg state;

parameter WAITING = 1'b0;
parameter CONVERTING = 1'b1;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WAITING;
        count <= 0;
        result <= 0;
        z <= 0;
    end
    else begin
        case (state)
            WAITING: begin
                if (x) begin
                    state <= CONVERTING;
                    count <= 1;
                    result <= 0;
                end
            end
            CONVERTING: begin
                if (count < 8) begin
                    result <= (result >> 1) | (x << 7);
                    count <= count + 1;
                end
                else begin
                    z <= ~result + 1;
                    state <= WAITING;
                end
            end
        endcase
    end
end

endmodule
