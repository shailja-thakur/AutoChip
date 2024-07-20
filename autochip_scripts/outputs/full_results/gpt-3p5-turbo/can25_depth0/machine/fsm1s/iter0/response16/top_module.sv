module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // State register
    reg [1:0] state;
    
    // Combinational logic block
    always @(*) begin
        if (state == 2'b00) begin
            if (in) begin
                state <= 2'b00; // Next state is A
            end else begin
                state <= 2'b01; // Next state is B
            end
        end else begin
            if (in) begin
                state <= 2'b01; // Next state is B
            end else begin
                state <= 2'b00; // Next state is A
            end
        end
    end
    
    // State update block
    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b01; // Reset to initial state B
        end else begin
            state <= state; // Update state based on combinational logic
        end
    end
    
    // Output assignment
    assign out = (state == 2'b01) ? 1'b1 : 1'b0;
    
endmodule
