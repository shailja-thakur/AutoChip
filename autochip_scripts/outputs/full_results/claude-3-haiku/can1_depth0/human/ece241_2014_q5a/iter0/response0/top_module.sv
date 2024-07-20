module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] complement;
reg state;

parameter IDLE = 1'b0, COMPUTE = 1'b1;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        count <= 0;
        complement <= 0;
        state <= IDLE;
        z <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= COMPUTE;
                end
            end
            COMPUTE: begin
                if (count == 8'd0) begin
                    complement <= ~count + 1;
                    z <= complement[0];
                    count <= count + 1;
                end
                else if (count < 8'd8) begin
                    complement <= {complement[6:0], x};
                    z <= complement[0];
                    count <= count + 1;
                end
                else begin
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
