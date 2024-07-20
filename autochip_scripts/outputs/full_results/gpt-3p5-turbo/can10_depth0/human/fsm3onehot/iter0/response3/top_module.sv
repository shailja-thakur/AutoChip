module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

// State transition and output logic
always @(*)
begin
    case(state)
        4'b0001: begin
            if(in == 1'b0) begin
                next_state = 4'b0001; // A stays in A if input is 0
                out = 1'b0; // Output is 0 for state A
            end
            else begin
                next_state = 4'b0010; // A transitions to B if input is 1
                out = 1'b0; // Output is 0 for state A
            end
        end
        
        4'b0010: begin
            if(in == 1'b0) begin
                next_state = 4'b0100; // B transitions to C if input is 0
                out = 1'b0; // Output is 0 for state B
            end
            else begin
                next_state = 4'b0010; // B stays in B if input is 1
                out = 1'b0; // Output is 0 for state B
            end
        end
        
        4'b0100: begin
            if(in == 1'b0) begin
                next_state = 4'b0001; // C transitions to A if input is 0
                out = 1'b0; // Output is 0 for state C
            end
            else begin
                next_state = 4'b1000; // C transitions to D if input is 1
                out = 1'b0; // Output is 0 for state C
            end
        end
        
        4'b1000: begin
            if(in == 1'b0) begin
                next_state = 4'b0100; // D transitions to C if input is 0
                out = 1'b1; // Output is 1 for state D
            end
            else begin
                next_state = 4'b0010; // D transitions to B if input is 1
                out = 1'b1; // Output is 1 for state D
            end
        end
    endcase
end

endmodule
