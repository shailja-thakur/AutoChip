module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] tmp;
reg state;

parameter IDLE = 1'b0;
parameter CONV = 1'b1;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        count <= 8'b0;
        tmp <= 8'b0;
        z <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= CONV;
                    count <= 8'b0;
                    tmp <= 8'b0;
                end
            end
            CONV: begin
                if (count == 8'd7) begin
                    z <= ~tmp + 1'b1;
                    state <= IDLE;
                end
                else begin
                    tmp[count] <= x;
                    count <= count + 1'b1;
                end
            end
            default: begin
                state <= IDLE;
                count <= 8'b0;
                tmp <= 8'b0;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
