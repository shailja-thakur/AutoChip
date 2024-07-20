module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
wire [2:0] w_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00; // Reset state A
    end else begin
        case (state)
            2'b00: begin // State A
                if (s) begin
                    state <= 2'b01; // Move to state B
                end else begin
                    state <= 2'b00; // Remain in state A
                end
            end
            
            2'b01: begin // State B
                if (w_count == 3'b010) begin
                    z <= 1'b1; // Set output z to 1
                end else begin
                    z <= 1'b0; // Set output z to 0
                end
                
                state <= 2'b01; // Remain in state B
            end
        endcase
    end
end

assign w_count = {w_count[1:0], w}; // Shift register for counting w input

endmodule
