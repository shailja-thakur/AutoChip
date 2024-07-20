module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

// State transition logic
always @(*) begin
    case (state)
        2'b00: // State A
            if (in) begin
                next_state = 2'b01; // A -> B
            end else begin
                next_state = 2'b00; // A -> A
            end
        2'b01: // State B
            if (in) begin
                next_state = 2'b01; // B -> B
            end else begin
                next_state = 2'b10; // B -> C
            end
        2'b10: // State C
            if (in) begin
                next_state = 2'b11; // C -> D
            end else begin
                next_state = 2'b00; // C -> A
            end
        2'b11: // State D
            if (in) begin
                next_state = 2'b01; // D -> B
            end else begin
                next_state = 2'b10; // D -> C
            end
    endcase
end

// State register and output logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00; // Reset to state A
        out <= 1'b0;
    end else begin
        state <= next_state;
        case (state)
            2'b00, 2'b01, 2'b10: // States A, B, C
                out <= 1'b0;
            2'b11: // State D
                out <= 1'b1;
        endcase
    end
end

endmodule
