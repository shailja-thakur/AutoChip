module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter STATE_IDLE = 0;
parameter STATE_COMPLEMENT = 1;

reg [1:0] state;
reg [7:0] input_reg;
reg [7:0] complement_reg;
reg [3:0] bit_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_IDLE;
        input_reg <= 0;
        complement_reg <= 0;
        bit_count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            STATE_IDLE: begin
                if (!areset) begin
                    state <= STATE_COMPLEMENT;
                    bit_count <= 0;
                end
            end
            STATE_COMPLEMENT: begin
                input_reg[bit_count] <= x;
                bit_count <= bit_count + 1;

                if (bit_count == 7) begin
                    complement_reg <= ~input_reg + 1;
                    bit_count <= 0;
                    z <= complement_reg[0];
                end
                else begin
                    z <= 0;
                end
            end
        endcase
    end
end

endmodule
