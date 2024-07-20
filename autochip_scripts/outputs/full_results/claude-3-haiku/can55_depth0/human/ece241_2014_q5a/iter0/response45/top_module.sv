module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 1'b0, CONVERT = 1'b1;
reg state;
reg [7:0] num, comp;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        num <= 0;
        comp <= 0;
        z <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= CONVERT;
                    num <= 0;
                    comp <= 0;
                end
            end
            CONVERT: begin
                num <= {num[6:0], x};
                comp <= {comp[6:0], ~x};
                if (x) begin
                    z <= 0;
                end
                else begin
                    z <= comp[7];
                end
            end
        endcase
    end
end

endmodule
