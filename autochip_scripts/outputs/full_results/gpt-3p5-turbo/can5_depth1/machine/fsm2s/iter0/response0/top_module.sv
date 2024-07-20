module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg [1:0] state;
reg [1:0] next_state;

// Initializing state to A
initial begin
    state <= 2'b00;
end

// Next state logic
always @(posedge clk, posedge reset) begin
    if (reset)
        state <= 2'b00;
    else
        state <= next_state;
end

// Output logic
always @(*) begin
    case (state)
        2'b00: begin    // State A
            next_state = (j) ? 2'b01 : 2'b00;
            out = 1'b0;
        end
        2'b01: begin    // State B
            next_state = (k) ? 2'b00 : 2'b01;
            out = 1'b1;
        end
        default: begin
            next_state = 2'b00;
            out = 1'b0;
        end
    endcase
end

endmodule
