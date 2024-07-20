module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states of the Moore state machine
parameter IDLE = 0, COMPLEMENT = 1;
reg state;

// Keep track of the input bits
reg [7:0] input_bits;
integer bit_count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        bit_count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= COMPLEMENT;
                    bit_count <= 0;
                end
            end
            COMPLEMENT: begin
                input_bits[bit_count] <= x;
                bit_count <= bit_count + 1;
                
                // Compute the 2's complement
                z <= ~input_bits[bit_count] + (bit_count == 7);
                
                // Stop the conversion when Reset is asserted
                if (areset) begin
                    state <= IDLE;
                    bit_count <= 0;
                end
            end
        endcase
    end
end

endmodule
