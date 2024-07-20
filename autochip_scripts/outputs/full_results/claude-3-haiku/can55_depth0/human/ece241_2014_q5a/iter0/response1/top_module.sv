module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// State variables
reg [3:0] state;
reg [7:0] input_reg;
reg [7:0] output_reg;
reg input_valid;

// State definitions
localparam IDLE = 4'b0000;
localparam INPUT = 4'b0001;
localparam INVERT = 4'b0010;
localparam OUTPUT = 4'b0011;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        input_reg <= 8'b0;
        output_reg <= 8'b0;
        input_valid <= 1'b0;
        z <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                if (!input_valid) begin
                    state <= INPUT;
                    input_reg <= 8'b0;
                    input_valid <= 1'b1;
                end
            end
            INPUT: begin
                input_reg <= {input_reg[6:0], x};
                if (input_valid) begin
                    state <= INVERT;
                end
            end
            INVERT: begin
                output_reg <= ~input_reg + 1'b1;
                state <= OUTPUT;
            end
            OUTPUT: begin
                z <= output_reg[0];
                output_reg <= {1'b0, output_reg[7:1]};
                if (output_reg == 8'b0) begin
                    state <= IDLE;
                    input_valid <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
