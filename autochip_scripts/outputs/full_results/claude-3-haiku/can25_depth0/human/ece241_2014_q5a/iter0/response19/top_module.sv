module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam STATE_RESET = 2'b00;
localparam STATE_COMPUTE = 2'b01;

reg [1:0] state;
reg [7:0] input_reg;
reg [7:0] neg_input;
reg [3:0] bit_count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_RESET;
        input_reg <= 8'b0;
        neg_input <= 8'b0;
        bit_count <= 4'b0;
        z <= 1'b0;
    end
    else begin
        case (state)
            STATE_RESET: begin
                if (!areset) begin
                    state <= STATE_COMPUTE;
                end
            end
            STATE_COMPUTE: begin
                input_reg <= {input_reg[6:0], x};
                bit_count <= bit_count + 1;

                if (bit_count == 4'd7) begin
                    neg_input <= ~input_reg + 1;
                    z <= neg_input[bit_count];
                    bit_count <= 4'b0;
                end
                else begin
                    z <= neg_input[bit_count];
                end
            end
            default: begin
                state <= STATE_RESET;
            end
        endcase
    end
end

endmodule
