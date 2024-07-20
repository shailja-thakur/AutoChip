module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

// Internal state
reg [2:0] state;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= 3'b100; // Initializing state to A
    end else begin
        case (state)
            3'b000: // State A
                if (x) begin
                    state <= 3'b001; // Next state is B
                end
            3'b001: // State B
                if (x) begin
                    state <= 3'b100; // Next state is E
                end
            3'b010: // State C
                if (x) begin
                    state <= 3'b001; // Next state is B
                end
            3'b011: // State D
                if (x) begin
                    state <= 3'b010; // Next state is C
                end
            3'b100: // State E
                if (x) begin
                    state <= 3'b011; // Next state is D
                end
        endcase
    end
end

assign z = (state == 3'b011 || state == 3'b100); // Output is high when state is D or E

endmodule
