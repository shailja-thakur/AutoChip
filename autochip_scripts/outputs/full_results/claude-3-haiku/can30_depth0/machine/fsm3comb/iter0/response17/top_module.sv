module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

always_comb begin
    case (state)
        2'b00: begin // State A
            if (in) begin
                next_state = 2'b01; // Move to State B
            end else begin
                next_state = 2'b00; // Remain in State A
            end
            out = 1'b0; // Out is not set
        end
        2'b01: begin // State B
            if (in) begin
                next_state = 2'b01; // Remain in State B
            end else begin
                next_state = 2'b10; // Move to State C
            end
            out = 1'b0; // Out is not set
        end
        2'b10: begin // State C
            if (in) begin
                next_state = 2'b11; // Move to State D
            end else begin
                next_state = 2'b00; // Move to State A
            end
            out = 1'b0; // Out is not set
        end
        2'b11: begin // State D
            if (in) begin
                next_state = 2'b01; // Move to State B
            end else begin
                next_state = 2'b10; // Move to State C
            end
            out = 1'b1; // Out is set
        end
        default: begin
            next_state = 2'b00; // Default to State A
            out = 1'b0; // Out is not set
        end
    endcase
end

endmodule
