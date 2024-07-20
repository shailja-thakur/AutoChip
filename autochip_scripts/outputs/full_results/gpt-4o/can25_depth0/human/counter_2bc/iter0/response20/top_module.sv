module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    // Define state constants
    localparam [1:0] SNT = 2'b00; // Strongly not-taken
    localparam [1:0] WNT = 2'b01; // Weakly not-taken
    localparam [1:0] WT  = 2'b10; // Weakly taken
    localparam [1:0] ST  = 2'b11; // Strongly taken

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WNT; // Reset to weakly not-taken
        end
        else if (train_valid) begin
            if (train_taken) begin
                if (state < ST) begin
                    state <= state + 1;
                end
            end
            else begin
                if (state > SNT) begin
                    state <= state - 1;
                end
            end
        end
    end
endmodule
