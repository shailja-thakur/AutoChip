module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] reg_val;
reg [2:0] state;

parameter IDLE = 3'b000, CONVERT = 3'b001, COMPLETE = 3'b010;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        reg_val <= 0;
        z <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (~areset) begin
                    state <= CONVERT;
                    reg_val <= 0;
                end
            end
            CONVERT: begin
                reg_val[0] <= x;
                reg_val <= {1'b0, reg_val[7:1]};
                z <= ~reg_val[0];
                if (areset) begin
                    state <= COMPLETE;
                end
            end
            COMPLETE: begin
                z <= 0;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
