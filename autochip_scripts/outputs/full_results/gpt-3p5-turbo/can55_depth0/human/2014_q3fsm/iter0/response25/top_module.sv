module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    reg [1:0] state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b0;
        else
            state <= next_state;
    end

    always @(state, w) begin
        case(state)
            0: begin // State A
                next_state = (s) ? 1 : 0;
                z <= 0;
            end
            1: begin // State B
                next_state = 2;
                z <= 0;
            end
            2: begin // State C
                next_state = 3;
                z <= 0;
            end
            3: begin // State D
                if (w)
                    next_state = 4;
                else
                    next_state = 2;
                z <= 0;
            end
            4: begin // State E
                if (w)
                    next_state = 5;
                else
                    next_state = 6;
                z <= 0;
            end
            5: begin // State F
                if (w)
                    next_state = 7;
                else
                    next_state = 8;
                z <= 0;
            end
            6: begin // State G
                if (w)
                    next_state = 8;
                else
                    next_state = 9;
                z <= 0;
            end
            7: begin // State H
                next_state = 10;
                z <= 0;
            end
            8: begin // State I
                next_state = 11;
                z <= 0;
            end
            9: begin // State J
                next_state = 12;
                z <= 0;
            end
            10: begin // State K
                next_state = 5;
                z <= 0;
            end
            11: begin // State L
                next_state = 9;
                z <= 0;
            end
            12: begin // State M
                next_state = 2;
                z <= 1;
            end
        endcase
    end
endmodule
