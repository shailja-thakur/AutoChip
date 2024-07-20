module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] temp;
reg state;

parameter WAITING = 1'b0, CONVERTING = 1'b1;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        count <= 0;
        temp <= 0;
        state <= WAITING;
        z <= 0;
    end
    else begin
        case (state)
            WAITING: begin
                if (~areset) begin
                    state <= CONVERTING;
                end
            end
            CONVERTING: begin
                if (count < 8) begin
                    temp[count] <= x;
                    count <= count + 1;
                end
                else begin
                    temp <= ~temp + 1;
                    count <= 0;
                    z <= temp[0];
                end
            end
        endcase
    end
end

endmodule
