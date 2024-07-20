module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000; // State A
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        3'b000: // State A
            if (x) begin
                next_state = 3'b001; // State B
            end
            else begin
                next_state = 3'b000; // State A
            end
        3'b001: // State B
            if (x) begin
                next_state = 3'b100; // State E
            end
            else begin
                next_state = 3'b001; // State B
            end
        3'b010: // State C
            if (x) begin
                next_state = 3'b001; // State B
            end
            else begin
                next_state = 3'b010; // State C
            end
        3'b011: // State D
            if (x) begin
                next_state = 3'b010; // State C
            end
            else begin
                next_state = 3'b001; // State B
            end
        3'b100: // State E
            if (x) begin
                next_state = 3'b100; // State E
            end
            else begin
                next_state = 3'b011; // State D
            end
        default:
            next_state = 3'b000; // State A
    endcase

    z = (state == 3'b011 || state == 3'b100); // Output z is high when in state D or E
end

endmodule
