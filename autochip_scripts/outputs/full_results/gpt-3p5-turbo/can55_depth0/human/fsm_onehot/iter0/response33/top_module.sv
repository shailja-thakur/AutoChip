module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    always @* begin
        case(state)
            10'b0000000001: begin
                next_state = 10'b0000000001;
                out1 = 1'b0;
                out2 = 1'b0;
            end

            10'b0000000010: begin
                next_state = 10'b0000000010;
                out1 = 1'b0;
                out2 = 1'b0;
            end

            10'b0000000011: begin
                next_state = 10'b0000000011;
                out1 = 1'b0;
                out2 = 1'b0;
            end

            10'b0000000100: begin
                next_state = 10'b0000000100;
                out1 = 1'b0;
                out2 = 1'b0;
            end

            10'b0000000101: begin
                next_state = 10'b0000000010;
                out1 = 1'b1;
                out2 = 1'b0;
            end

            10'b0000000110: begin
                next_state = 10'b0000001001;
                out1 = 1'b0;
                out2 = 1'b0;
            end

            10'b0000000111: begin
                next_state = 10'b0000001110;
                out1 = 1'b0;
                out2 = 1'b1;
            end

            10'b0000001000: begin
                next_state = 10'b0000000001;
                out1 = 1'b0;
                out2 = 1'b0;
            end

            10'b0000001001: begin
                next_state = 10'b0000000010;
                out1 = 1'b1;
                out2 = 1'b0;
            end

            10'b0000001010: begin
                next_state = 10'b0000000000;
                out1 = 1'b1;
                out2 = 1'b0;
            end

            default: begin
                next_state = 10'b0000000000;
                out1 = 1'b0;
                out2 = 1'b0;
            end
        endcase
    end

endmodule
