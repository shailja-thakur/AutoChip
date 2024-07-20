module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] complement;
reg state;

parameter IDLE = 1'b0;
parameter COMPUTE = 1'b1;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        count <= 0;
        complement <= 0;
        z <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= COMPUTE;
                    count <= 1;
                    complement <= 0;
                end
            end
            COMPUTE: begin
                complement <= {complement[6:0], x};
                count <= count + 1;
                if (count == 8) begin
                    complement <= ~complement + 1;
                    z <= complement[0];
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
