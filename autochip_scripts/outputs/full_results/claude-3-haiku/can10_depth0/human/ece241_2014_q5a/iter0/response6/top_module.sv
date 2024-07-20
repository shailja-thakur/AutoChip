module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] complement;
reg state;

parameter INIT = 0, COMP = 1;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= INIT;
        count <= 0;
        complement <= 0;
        z <= 0;
    end
    else begin
        case (state)
            INIT: begin
                if (!areset) begin
                    state <= COMP;
                end
            end
            COMP: begin
                if (count < 8) begin
                    complement <= (complement >> 1) | (x << 7);
                    count <= count + 1;
                    z <= ~complement[0];
                end
                else begin
                    state <= INIT;
                    count <= 0;
                    complement <= 0;
                end
            end
            default: begin
                state <= INIT;
            end
        endcase
    end
end

endmodule
