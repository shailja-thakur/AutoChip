module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] input_reg;
reg [7:0] complement_reg;
reg [2:0] state;

parameter [2:0] RESET = 3'b000, 
                LOAD = 3'b001,
                COMPLEMENT = 3'b010,
                OUTPUT = 3'b011;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= RESET;
        input_reg <= 8'b0;
        complement_reg <= 8'b0;
        z <= 1'b0;
    end
    else begin
        case (state)
            RESET: begin
                state <= LOAD;
            end
            LOAD: begin
                input_reg <= {input_reg[6:0], x};
                if (areset) begin
                    state <= RESET;
                end
                else begin
                    state <= COMPLEMENT;
                end
            end
            COMPLEMENT: begin
                complement_reg <= ~input_reg + 1'b1;
                state <= OUTPUT;
            end
            OUTPUT: begin
                z <= complement_reg[0];
                complement_reg <= {1'b0, complement_reg[7:1]};
                if (complement_reg == 8'b0) begin
                    state <= RESET;
                end
                else begin
                    state <= OUTPUT;
                end
            end
        endcase
    end
end

endmodule
