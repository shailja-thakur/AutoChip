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
parameter CONVERT = 1'b1;

always @(posedge clk or posedge areset) begin
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
                    state <= CONVERT;
                    count <= 0;
                    complement <= 0;
                end
            end
            CONVERT: begin
                count <= count + 1;
                complement <= (complement >> 1) | (x << 7);
                z <= ~complement[0];
                if (count == 8) begin
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
