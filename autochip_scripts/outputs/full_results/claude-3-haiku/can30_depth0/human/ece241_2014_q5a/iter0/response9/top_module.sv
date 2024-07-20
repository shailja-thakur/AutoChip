module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [31:0] input_reg;
reg [31:0] output_reg;
reg [5:0] state;

localparam [5:0] 
    IDLE = 6'b000001,
    SHIFT = 6'b000010,
    NEGATE = 6'b000100,
    DONE = 6'b001000;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        input_reg <= 0;
        output_reg <= 0;
        z <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= SHIFT;
                    input_reg <= 0;
                end
            end
            SHIFT: begin
                input_reg <= {input_reg[30:0], x};
                if (input_reg[31]) begin
                    state <= NEGATE;
                    output_reg <= ~input_reg + 1;
                end
                else if (areset) begin
                    state <= IDLE;
                end
            end
            NEGATE: begin
                z <= output_reg[0];
                output_reg <= {output_reg[30:0], 1'b0};
                if (output_reg == 0) begin
                    state <= DONE;
                end
            end
            DONE: begin
                if (areset) begin
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
