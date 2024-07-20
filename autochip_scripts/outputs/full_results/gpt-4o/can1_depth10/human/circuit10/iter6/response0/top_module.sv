module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        // Update state based on inputs a and b
        case ({a, b})
            2'b00: state <= state;  // No change
            2'b01: state <= 1;      // Set state to 1
            2'b10: state <= 0;      // Set state to 0
            2'b11: state <= ~state; // Toggle state
            default: state <= state;
        endcase
        
        // Output q is same as state
        q <= state;
    end

endmodule
