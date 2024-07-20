module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states of the state machine
localparam [1:0] 
    RESET = 2'b00, 
    CONVERT = 2'b01, 
    DONE = 2'b11;

// Internal state variable
reg [1:0] state;

// Internal variable to store the binary number
reg [7:0] num;

// Internal variable to track the bit position
reg [2:0] bit_pos;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= RESET;
        num <= 8'b0;
        bit_pos <= 3'b0;
        z <= 1'b0;
    end
    else begin
        case (state)
            RESET: begin
                state <= CONVERT;
            end
            CONVERT: begin
                // Shift the input bit into the number
                num <= {num[6:0], x};
                // Increment the bit position
                bit_pos <= bit_pos + 1;
                // Output the 2's complement of the current bit
                z <= ~num[bit_pos] + x;
                // When all bits have been processed, move to the DONE state
                if (bit_pos == 7) begin
                    state <= DONE;
                end
            end
            DONE: begin
                // Hold the output until the next reset
                z <= z;
            end
            default: begin
                state <= RESET;
            end
        endcase
    end
end

endmodule
