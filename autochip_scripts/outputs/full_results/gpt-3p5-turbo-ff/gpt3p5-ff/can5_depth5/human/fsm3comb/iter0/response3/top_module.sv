module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);
always @(*) begin
    case (state)
        2'b00: begin
            case (in)
                1'b0: begin
                    next_state = 2'b00;
                    out = 1'b0;
                end
                1'b1: begin
                    next_state = 2'b01;
                    out = 1'b0;
                end
            endcase
        end
        2'b01: begin
            case (in)
                1'b0: begin
                    next_state = 2'b10;
                    out = 1'b0;
                end
                1'b1: begin
                    next_state = 2'b01;
                    out = 1'b0;
                end
            endcase
        end
        2'b10: begin
            case (in)
                1'b0: begin
                    next_state = 2'b00;
                    out = 1'b0;
                end
                1'b1: begin
                    next_state = 2'b11;
                    out = 1'b0;
                end
            endcase
        end
        2'b11: begin
            case (in)
                1'b0: begin
                    next_state = 2'b10;
                    out = 1'b1;
                end
                1'b1: begin
                    next_state = 2'b01;
                    out = 1'b0;
                end
            endcase
        end
    endcase
end
endmodule
