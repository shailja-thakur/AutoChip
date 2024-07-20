module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states for the Moore state machine
localparam STATE_INIT = 2'b00;
localparam STATE_CONVERT = 2'b01;
localparam STATE_DONE = 2'b11;

// State register
reg [1:0] state;

// Input number register
reg [7:0] num;

// Temporary variable to store the 2's complement
reg [7:0] complement;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        // Reset the state machine
        state <= STATE_INIT;
        z <= 1'b0;
        num <= 8'b0;
        complement <= 8'b0;
    end
    else begin
        case (state)
            STATE_INIT: begin
                // Initialize the state
                state <= STATE_CONVERT;
            end
            STATE_CONVERT: begin
                // Shift the input bit into the least-significant bit of the number register
                num <= {num[6:0], x};
                
                // Calculate the 2's complement
                complement <= ~num + 1'b1;
                
                // Output the least-significant bit of the 2's complement
                z <= complement[0];
                
                // Check if all bits have been processed
                if (num[7]) begin
                    state <= STATE_DONE;
                end
                else begin
                    state <= STATE_CONVERT;
                end
            end
            STATE_DONE: begin
                // Hold the output and wait for the next reset
                z <= 1'b0;
            end
            default: begin
                // Invalid state, go to the initial state
                state <= STATE_INIT;
            end
        endcase
    end
end

endmodule
