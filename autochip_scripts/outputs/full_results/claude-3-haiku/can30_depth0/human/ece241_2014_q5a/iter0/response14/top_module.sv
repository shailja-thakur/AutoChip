module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] input_reg;
reg [7:0] complement;
reg [2:0] state;

localparam [2:0] 
    IDLE = 3'b000,
    ACCEPT = 3'b001, 
    COMPLEMENT = 3'b010,
    OUTPUT = 3'b011;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        input_reg <= 8'b0;
        complement <= 8'b0;
        z <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= ACCEPT;
                end
            end
            ACCEPT: begin
                input_reg <= {input_reg[6:0], x};
                state <= COMPLEMENT;
            end
            COMPLEMENT: begin
                complement <= ~input_reg + 1'b1;
                state <= OUTPUT;
            end
            OUTPUT: begin
                z <= complement[0];
                complement <= {1'b0, complement[7:1]};
                if (complement == 8'b0) begin
                    state <= IDLE;
                end
                else begin
                    state <= OUTPUT;
                end
            end
        endcase
    end
end

endmodule
