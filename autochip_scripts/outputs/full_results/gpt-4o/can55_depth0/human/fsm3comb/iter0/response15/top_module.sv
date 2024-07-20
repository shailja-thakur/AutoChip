module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

always @(*) begin
    case (state)
        2'b00: begin // State A
            if (in == 1'b0)
                next_state = 2'b00; // A
            else
                next_state = 2'b01; // B
            out = 1'b0;
        end
        
        2'b01: begin // State B
            if (in == 1'b0)
                next_state = 2'b10; // C
            else
                next_state = 2'b01; // B
            out = 1'b0;
        end
        
        2'b10: begin // State C
            if (in == 1'b0)
                next_state = 2'b00; // A
            else
                next_state = 2'b11; // D
            out = 1'b0;
        end
        
        2'b11: begin // State D
            if (in == 1'b0)
                next_state = 2'b10; // C
            else
                next_state = 2'b01; // B
            out = 1'b1;
        end
        
        default: begin
            next_state = 2'b00; // default state A
            out = 1'b0;
        end
    endcase
end

endmodule
