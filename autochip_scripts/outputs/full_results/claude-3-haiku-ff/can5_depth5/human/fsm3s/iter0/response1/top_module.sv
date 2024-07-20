module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00; // State A
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        2'b00: // State A
            if (in == 1'b0) begin
                next_state = 2'b00; // A
                out = 1'b0;
            end
            else begin
                next_state = 2'b01; // B
                out = 1'b0;
            end
        2'b01: // State B
            if (in == 1'b0) begin
                next_state = 2'b10; // C
                out = 1'b0;
            end
            else begin
                next_state = 2'b01; // B
                out = 1'b0;
            end
        2'b10: // State C
            if (in == 1'b0) begin
                next_state = 2'b00; // A
                out = 1'b0;
            end
            else begin
                next_state = 2'b11; // D
                out = 1'b0;
            end
        2'b11: // State D
            if (in == 1'b0) begin
                next_state = 2'b10; // C
                out = 1'b1;
            end
            else begin
                next_state = 2'b01; // B
                out = 1'b1;
            end
        default:
            begin
                next_state = 2'b00; // A
                out = 1'b0;
            end
    endcase
end

endmodule
