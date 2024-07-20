module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

    always @(*) begin
        case (state)
            2'b00: begin // A
                next_state = in ? 2'b01 : 2'b00; // A->A or A->B
                out = 1'b0;
            end
            2'b01: begin // B
                next_state = in ? 2'b01 : 2'b10; // B->B or B->C
                out = 1'b0;
            end
            2'b10: begin // C
                next_state = in ? 2'b11 : 2'b00; // C->D or C->A
                out = 1'b0;
            end
            2'b11: begin // D
                next_state = in ? 2'b01 : 2'b10; // D->B or D->C
                out = 1'b1;
            end
            default: begin
                next_state = 2'b00; // Default to state A is safety net
                out = 1'b0;
            end
        endcase
    end

endmodule
