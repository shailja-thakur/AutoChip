module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam STATE_IDLE = 2'b00;
localparam STATE_COMPUTE = 2'b01;

reg [1:0] state;
reg [7:0] accumulator;
reg [3:0] bit_count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_IDLE;
        accumulator <= 0;
        bit_count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            STATE_IDLE: begin
                if (!areset) begin
                    state <= STATE_COMPUTE;
                    bit_count <= 0;
                    accumulator <= 0;
                end
            end
            STATE_COMPUTE: begin
                if (bit_count == 8) begin
                    state <= STATE_IDLE;
                    z <= ~accumulator + 1;
                end
                else begin
                    accumulator <= (accumulator >> 1) | (x << 7);
                    bit_count <= bit_count + 1;
                end
            end
            default: begin
                state <= STATE_IDLE;
            end
        endcase
    end
end

endmodule
