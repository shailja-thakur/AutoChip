module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

always @(*) begin
    case (state)
        2'b00: begin // A state
            if (in == 1'b0) begin
                next_state = 2'b00; // Stay in A
            end else begin
                next_state = 2'b01; // Move to B
            end
            out = 1'b0;
        end
        2'b01: begin // B state
            if (in == 1'b0) begin
                next_state = 2'b10; // Move to C
            end else begin
                next_state = 2'b01; // Stay in B
            end
            out = 1'b0;
        end
        2'b10: begin // C state
            if (in == 1'b0) begin
                next_state = 2'b00; // Move to A
            end else begin
                next_state = 2'b11; // Move to D
            end
            out = 1'b0;
        end
        2'b11: begin // D state
            if (in == 1'b0) begin
                next_state = 2'b10; // Move to C
            end else begin
                next_state = 2'b01; // Move to B
            end
            out = 1'b1;
        end
        default: begin
            next_state = 2'b00; // Default state A
            out = 1'b0;
        end
    endcase
end

endmodule
