module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 1'b0, COMPUTE = 1'b1;
reg state;
reg [7:0] input_reg;
reg [7:0] complement_reg;
reg [3:0] bit_count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        input_reg <= 8'b0;
        complement_reg <= 8'b0;
        bit_count <= 4'b0;
        z <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (~areset) begin
                    state <= COMPUTE;
                end
            end
            COMPUTE: begin
                input_reg <= {input_reg[6:0], x};
                bit_count <= bit_count + 1;
                if (bit_count == 4'd8) begin
                    complement_reg <= ~input_reg + 1'b1;
                    bit_count <= 4'b0;
                end
                z <= complement_reg[0];
                complement_reg <= {complement_reg[6:0], 1'b0};
            end
        endcase
    end
end

endmodule
