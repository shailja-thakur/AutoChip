module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [7:0] input_reg;
reg [7:0] output_reg;
reg [2:0] state;

parameter [2:0] IDLE = 3'b000, 
                CONVERT = 3'b001, 
                FINISH = 3'b010;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        input_reg <= 8'b0;
        output_reg <= 8'b0;
        state <= IDLE;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= CONVERT;
                end
            end
            CONVERT: begin
                input_reg <= {input_reg[6:0], x};
                output_reg <= ~input_reg + 1'b1;
                if (areset) begin
                    state <= FINISH;
                end
            end
            FINISH: begin
                // Hold the final output
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

assign z = output_reg[0];

endmodule
