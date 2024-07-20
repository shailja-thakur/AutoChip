module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] complement;
reg state;

parameter IDLE = 1'b0, CONVERT = 1'b1;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        count <= 0;
        complement <= 0;
        state <= IDLE;
        z <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (~areset) begin
                    state <= CONVERT;
                end
            end
            CONVERT: begin
                if (count == 7) begin
                    state <= IDLE;
                    z <= ~complement[0];
                end
                else begin
                    complement <= {complement[6:0], x};
                    count <= count + 1;
                    z <= ~complement[0];
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
