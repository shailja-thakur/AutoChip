module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states
parameter WAIT = 0, COMP = 1;
reg state, next_state;

// Registers to store the input and its 2's complement
reg [7:0] input_reg, complement;
reg [3:0] bit_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WAIT;
        input_reg <= 0;
        complement <= 0;
        bit_count <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            WAIT: begin
                if (!areset) begin
                    input_reg <= {input_reg[6:0], x};
                    bit_count <= bit_count + 1;
                    if (bit_count == 7) begin
                        next_state <= COMP;
                    end
                end
            end
            COMP: begin
                complement <= ~input_reg + 1;
                z <= complement[0];
                complement <= {complement[6:0], 1'b0};
                if (bit_count == 0) begin
                    next_state <= WAIT;
                    bit_count <= 0;
                end
                else begin
                    bit_count <= bit_count - 1;
                end
            end
        endcase
    end
end

endmodule
