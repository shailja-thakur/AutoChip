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
                next_state = 2'b01; // State B
            end else begin
                next_state = 2'b00; // State A
            end
            out = 1'b0;
        end
        2'b01: begin // State B
            if (in) begin
                next_state = 2'b01; // State B
            end else begin
                next_state = 2'b10; // State C
            end
            out = 1'b0;
        end
        2'b10: begin // State C
            if (in) begin
                next_state = 2'b11; // State D
            end else begin
                next_state = 2'b00; // State A
            end
            out = 1'b0;
        end
        2'b11: begin // State D
            if (in) begin
                next_state = 2'b01; // State B
            end else begin
                next_state = 2'b10; // State C
            end
            out = 1'b1;
        end
        default: begin
            next_state = 2'b00; // State A
            out = 1'b0;
        end
    endcase
end

endmodule
