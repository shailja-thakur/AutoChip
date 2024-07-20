module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] reg_val;
reg state;

parameter IDLE = 1'b0;
parameter CONVERT = 1'b1;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        reg_val <= 8'b0;
        state <= IDLE;
        z <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (x == 1'b0) begin
                    reg_val <= 8'b0;
                    state <= CONVERT;
                end
            end
            CONVERT: begin
                reg_val[7:0] <= {reg_val[6:0], x};
                if (x == 1'b1) begin
                    z <= ~reg_val[7:0] + 1'b1;
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
