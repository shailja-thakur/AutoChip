module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

always @(*)
begin
    case(state)
        2'b00: // A
            begin
                if(in)
                begin
                    next_state = 2'b01; // B
                    out = 1'b0;
                end
                else
                begin
                    next_state = 2'b00; // A
                    out = 1'b0;
                end
            end
            
        2'b01: // B
            begin
                if(in)
                begin
                    next_state = 2'b01; // B
                    out = 1'b0;
                end
                else
                begin
                    next_state = 2'b10; // C
                    out = 1'b0;
                end
            end
            
        2'b10: // C
            begin
                if(in)
                begin
                    next_state = 2'b11; // D
                    out = 1'b0;
                end
                else
                begin
                    next_state = 2'b00; // A
                    out = 1'b0;
                end
            end
            
        2'b11: // D
            begin
                if(in)
                begin
                    next_state = 2'b01; // B
                    out = 1'b1;
                end
                else
                begin
                    next_state = 2'b10; // C
                    out = 1'b0;
                end
            end
    endcase
end

endmodule
