module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= 3'b000; // State A
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        3'b000: // State A
            if (x) begin
                next_state = 3'b001; // State B
            end else begin
                next_state = 3'b000; // State A
            end
        3'b001: // State B
            if (x) begin
                next_state = 3'b100; // State E
            end else begin
                next_state = 3'b001; // State B
            end
        3'b010: // State C
            if (x) begin
                next_state = 3'b001; // State B
            end else begin
                next_state = 3'b010; // State C
            end
        3'b011: // State D
            if (x) begin
                next_state = 3'b010; // State C
            end else begin
                next_state = 3'b001; // State B
            end
        3'b100: // State E
            if (x) begin
                next_state = 3'b100; // State E
            end else begin
                next_state = 3'b011; // State D
            end
        default:
            next_state = 3'b000; // State A
    endcase
end

always @(*) begin
    if (state == 3'b011 || state == 3'b100) // State D or E
        z = 1'b1;
    else
        z = 1'b0;
end

endmodule
