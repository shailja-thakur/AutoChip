module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 0, COMPUTE = 1;
reg [0:0] state;
reg [31:0] num;
reg [31:0] comp;

always @(posedge clk, posedge areset) begin
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
                    state <= COMPUTE;
                    num <= 0;
                    comp <= 0;
                end
            end
            COMPUTE: begin
                num <= {num[30:0], x};
                comp <= {comp[30:0], ~x};
                if (x) begin
                    z <= 1;
                end
                else begin
                    z <= 0;
                end
                if (areset) begin
                    state <= IDLE;
                    z <= 0;
                end
            end
        endcase
    end
end

endmodule
