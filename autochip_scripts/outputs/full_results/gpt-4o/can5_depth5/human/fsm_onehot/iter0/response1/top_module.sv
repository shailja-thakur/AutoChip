module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2);

    always @(*) begin
        // Default assignments
        next_state = 10'b0000000000;
        out1 = 0;
        out2 = 0;
        
        // State transition logic
        case (1'b1) // synthesis full_case
            state[0]: begin
                if (in)
                    next_state = 10'b0000000010;
                else
                    next_state = 10'b0000000001;
            end
            
            state[1]: begin
                if (in)
                    next_state = 10'b0000000100;
                else
                    next_state = 10'b0000000001;
            end
            
            state[2]: begin
                if (in)
                    next_state = 10'b0000001000;
                else
                    next_state = 10'b0000000001;
            end

            state[3]: begin
                if (in)
                    next_state = 10'b0000010000;
                else
                    next_state = 10'b0000000001;
            end

            state[4]: begin
                if (in)
                    next_state = 10'b0000100000;
                else
                    next_state = 10'b0000000001;
            end

            state[5]: begin
                if (in)
                    next_state = 10'b0001000000;
                else
                    next_state = 10'b1000000000;
            end

            state[6]: begin
                if (in)
                    next_state = 10'b0010000000;
                else
                    next_state = 10'b0100000000;
            end

            state[7]: begin
                if (in) begin
                    next_state = 10'b0010000000;
                    out2 = 1;
                end
                else begin
                    next_state = 10'b0000000001;
                    out2 = 1;
                end
            end

            state[8]: begin
                next_state = (in ? 10'b0000000010 : 10'b0000000001);
                out1 = 1;
            end
            
            state[9]: begin
                next_state = (in ? 10'b0000000010 : 10'b0000000001);
                out1 = 1;
                out2 = 1;
            end
        endcase
    end
endmodule
