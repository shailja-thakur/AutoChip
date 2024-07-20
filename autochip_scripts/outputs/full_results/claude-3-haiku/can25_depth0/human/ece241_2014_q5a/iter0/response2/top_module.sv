module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states of the Moore state machine
localparam STATE_RESET = 2'b00;
localparam STATE_COMPUTE = 2'b01;

// Define the internal registers
reg [1:0] state;
reg [7:0] input_number;
reg [7:0] complement;
reg [3:0] bit_count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset the state machine
        state <= STATE_RESET;
        bit_count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            STATE_RESET: begin
                // Wait for the reset to be released
                if (!areset) begin
                    state <= STATE_COMPUTE;
                    bit_count <= 0;
                    input_number <= 0;
                    complement <= 0;
                end
            end
            STATE_COMPUTE: begin
                // Shift the input bit into the input number
                input_number <= {input_number[6:0], x};
                bit_count <= bit_count + 1;

                // Compute the 2's complement of the input number
                complement <= ~input_number + 1;

                // Output the current bit of the 2's complement
                z <= complement[bit_count];

                // Stop the conversion when all bits have been processed
                if (bit_count == 7) begin
                    state <= STATE_RESET;
                end
            end
            default: begin
                state <= STATE_RESET;
            end
        endcase
    end
end

endmodule
