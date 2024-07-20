module top_module (
    input clk,
    input areset,
    input x,
    output z
);

parameter IDLE = 2'b00;
parameter COMPUTE = 2'b01;
parameter DONE = 2'b11;

reg [1:0] state;
reg [7:0] num;
reg [7:0] complement;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        num <= 0;
        complement <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= COMPUTE;
                end
            end
            COMPUTE: begin
                num <= {num[6:0], x};
                complement <= {complement[6:0], ~x};
                if (areset) begin
                    state <= DONE;
                end
            end
            DONE: begin
                complement <= complement + 1;
                z <= complement[0];
                if (!areset) begin
                    state <= COMPUTE;
                    num <= 0;
                    complement <= 0;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
