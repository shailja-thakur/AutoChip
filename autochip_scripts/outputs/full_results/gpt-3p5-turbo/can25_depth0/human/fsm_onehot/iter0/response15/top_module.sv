module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    // Combinational logic for state transition and output generation
    always @(*) begin
        case(state)
            10'b000_000_000: begin
                next_state = 10'b000_000_001;
                out1 = 0;
                out2 = 0;
            end
            10'b000_000_001: begin
                next_state = (in == 1) ? 10'b000_000_010 : 10'b000_000_000;
                out1 = 0;
                out2 = 0;
            end
            10'b000_000_010: begin
                next_state = (in == 1) ? 10'b000_000_011 : 10'b000_000_000;
                out1 = 0;
                out2 = 0;
            end
            10'b000_000_011: begin
                next_state = (in == 1) ? 10'b000_000_100 : 10'b000_000_000;
                out1 = 0;
                out2 = 0;
            end
            10'b000_000_100: begin
                next_state = (in == 1) ? 10'b000_000_101 : 10'b000_000_000;
                out1 = 0;
                out2 = 0;
            end
            10'b000_000_101: begin
                next_state = (in == 1) ? 10'b000_001_000 : 10'b000_000_110;
                out1 = 0;
                out2 = 0;
            end
            10'b000_000_110: begin
                next_state = (in == 1) ? 10'b000_000_101 : 10'b000_000_111;
                out1 = 0;
                out2 = 0;
            end
            10'b000_000_111: begin
                next_state = (in == 1) ? 10'b000_000_000 : 10'b000_000_111;
                out1 = 0;
                out2 = 1;
            end
            10'b000_001_000: begin
                next_state = (in == 1) ? 10'b000_000_001 : 10'b000_000_000;
                out1 = 1;
                out2 = 0;
            end
            10'b000_001_001: begin
                next_state = (in == 1) ? 10'b000_000_001 : 10'b000_000_000;
                out1 = 1;
                out2 = 1;
            end
            default: begin
                next_state = 10'b000_000_000;
                out1 = 0;
                out2 = 0;
            end
        endcase
    end
endmodule
