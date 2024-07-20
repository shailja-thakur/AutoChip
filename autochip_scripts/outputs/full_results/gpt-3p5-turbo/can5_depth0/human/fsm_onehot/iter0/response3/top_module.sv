module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    reg [9:0] next_state;
    reg out1;
    reg out2;

    always @(*) begin
        case(state)
            10'b0000000001: begin
                next_state = 10'b0000000001;
                out1 = 1'b0;
                out2 = 1'b0;
            end
            10'b0000000010: begin
                if(in == 1'b0) begin
                    next_state = 10'b0000000001;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
                else begin
                    next_state = 10'b0000000010;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            10'b0000000011: begin
                if(in == 1'b0) begin
                    next_state = 10'b0000000001;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
                else begin
                    next_state = 10'b0000000100;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            10'b0000000100: begin
                if(in == 1'b0) begin
                    next_state = 10'b0000000001;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
                else begin
                    next_state = 10'b0000000101;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            10'b0000000101: begin
                if(in == 1'b0) begin
                    next_state = 10'b0000000001;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
                else begin
                    next_state = 10'b0000000110;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            10'b0000000110: begin
                if(in == 1'b0) begin
                    next_state = 10'b0000001001;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
                else begin
                    next_state = 10'b0000000111;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            10'b0000001000: begin
                next_state = 10'b0000000001;
                out1 = 1'b0;
                out2 = 1'b0;
            end
            10'b0000001001: begin
                if(in == 1'b0) begin
                    next_state = 10'b0000000001;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
                else begin
                    next_state = 10'b0000000010;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            10'b0000001010: begin
                if(in == 1'b0) begin
                    next_state = 10'b0000000001;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
                else begin
                    next_state = 10'b0000000010;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            10'b0000001011: begin
                if(in == 1'b0) begin
                    next_state = 10'b0000000001;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
                else begin
                    next_state = 10'b0000000010;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            default: begin
                next_state = 10'b0000000000;
                out1 = 1'b0;
                out2 = 1'b0;
            end
        endcase
    end
endmodule
