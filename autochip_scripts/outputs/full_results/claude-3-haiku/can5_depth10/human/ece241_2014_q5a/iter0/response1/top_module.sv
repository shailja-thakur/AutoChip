module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] result;
reg state;

parameter IDLE = 1'b0;
parameter COMPUTE = 1'b1;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        count <= 8'b0;
        result <= 8'b0;
        z <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= COMPUTE;
                    count <= 8'b0;
                    result <= 8'b0;
                end
            end
            COMPUTE: begin
                if (count < 8'd8) begin
                    result[count] <= x;
                    count <= count + 8'd1;
                end
                else begin
                    result <= ~result + 1'b1;
                    z <= result[count-1];
                    state <= IDLE;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
