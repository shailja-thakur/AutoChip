module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] count;
reg [7:0] complement;
reg [1:0] state;

parameter IDLE = 2'b00;
parameter COMPUTE = 2'b01;
parameter COMPLETE = 2'b11;

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
                if (!areset) begin
                    state <= COMPUTE;
                end
            end
            COMPUTE: begin
                complement <= (complement >> 1) | (x << 7);
                count <= count + 1;
                if (count == 7) begin
                    state <= COMPLETE;
                    z <= ~complement + 1;
                end
            end
            COMPLETE: begin
                if (areset) begin
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
