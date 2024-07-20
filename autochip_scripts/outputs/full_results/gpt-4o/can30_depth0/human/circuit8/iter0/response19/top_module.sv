module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg [1:0] state; // 00 = state 0, 01 = state 1, 10 = state2

    always @(posedge clock)
    begin
        case(state)
            2'b00:  // Initial state
            begin
                p <= 0;
                q <= 0;
                if(a)
                    state <= 2'b01;
            end
            2'b01:  // First state
            begin
                p <= 1;
                q <= 0;
                if(!a)
                    state <= 2'b10;
            end
            2'b10:  // Second state
            begin
                p <= 1;
                q <= 1;
                if(!a)
                    state <= 2'b00;
            end
            default:
                state <= 2'b00;
        endcase
    end

    // To handle synchronous resets
    always @(negedge clock) begin
        if(!a) begin
            p <= 0;
            q <= 0;
        end
    end

endmodule
