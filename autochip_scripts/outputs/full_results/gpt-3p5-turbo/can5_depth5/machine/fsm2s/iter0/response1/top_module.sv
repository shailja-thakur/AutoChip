module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

    reg [1:0] state;
    wire j_next, k_next;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b0;
        end else begin
            state <= j_next;
        end
    end

    // Next state logic
    assign j_next = (state == 2'b00 && j) ? 2'b1 : 2'b0;
    assign k_next = (state == 2'b01 && k) ? 2'b0 : 2'b1;

    // Output logic
    assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
