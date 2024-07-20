module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] complement;
reg state;

localparam IDLE = 1'b0;
localparam COMPUTE = 1'b1;

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
                    state <= COMPUTE;
                    count <= 0;
                    complement <= 0;
                end
            end
            COMPUTE: begin
                complement <= complement | (x << count);
                count <= count + 1;
                if (x == 0 && count == 7) begin
                    complement <= ~complement + 1;
                    z <= complement[0];
                    state <= IDLE;
                end
                else begin
                    z <= complement[0];
                end
            end
        endcase
    end
end

endmodule
