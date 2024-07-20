module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam STATE_RESET = 2'b00;
localparam STATE_COMPUTE = 2'b01;
localparam STATE_OUTPUT = 2'b10;

reg [1:0] state;
reg [7:0] input_reg;
reg [7:0] output_reg;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_RESET;
        input_reg <= 8'b0;
        output_reg <= 8'b0;
        z <= 1'b0;
    end
    else begin
        case (state)
            STATE_RESET: begin
                state <= STATE_COMPUTE;
            end
            STATE_COMPUTE: begin
                input_reg <= {input_reg[6:0], x};
                if (input_reg[7]) begin
                    output_reg <= ~input_reg + 1'b1;
                    state <= STATE_OUTPUT;
                end
            end
            STATE_OUTPUT: begin
                z <= output_reg[0];
                output_reg <= {1'b0, output_reg[7:1]};
                if (output_reg == 8'b0) begin
                    state <= STATE_RESET;
                end
            end
        endcase
    end
end

endmodule
