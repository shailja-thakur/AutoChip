module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

// State transition logic
always @(*)
begin
    case(state)
        2'b00:   // A
        begin
            if(in == 1'b0)
                next_state = 2'b00; // A
            else
                next_state = 2'b01; // B
        end
        
        2'b01:   // B
        begin
            if(in == 1'b0)
                next_state = 2'b10; // C
            else
                next_state = 2'b01; // B
        end
        
        2'b10:   // C
        begin
            if(in == 1'b0)
                next_state = 2'b00; // A
            else
                next_state = 2'b11; // D
        end
        
        2'b11:   // D
        begin
            if(in == 1'b0)
                next_state = 2'b10; // C
            else
                next_state = 2'b01; // B
        end
    endcase
end

// Output logic
always @(state)
begin
    case(state)
        2'b00, 2'b01, 2'b10:
            out = 1'b0;
        2'b11:
            out = 1'b1;
    endcase
end

endmodule
