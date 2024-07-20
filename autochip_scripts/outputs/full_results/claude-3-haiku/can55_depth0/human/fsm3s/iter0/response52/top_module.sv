module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    reg [1:0] state, next_state;
    
    always @(posedge clk) begin
        if (reset)
            state <= 2'b00; // reset to state A
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            2'b00: begin // State A
                if (in == 0)
                    next_state = 2'b00; // A -> A
                else
                    next_state = 2'b01; // A -> B
                out = 0;
            end
            2'b01: begin // State B
                if (in == 0)
                    next_state = 2'b10; // B -> C
                else
                    next_state = 2'b01; // B -> B
                out = 0;
            end
            2'b10: begin // State C
                if (in == 0)
                    next_state = 2'b00; // C -> A
                else
                    next_state = 2'b11; // C -> D
                out = 0;
            end
            2'b11: begin // State D
                if (in == 0)
                    next_state = 2'b10; // D -> C
                else
                    next_state = 2'b01; // D -> B
                out = 1;
            end
            default: begin
                next_state = 2'b00; // Reset to state A
                out = 0;
            end
        endcase
    end

endmodule
