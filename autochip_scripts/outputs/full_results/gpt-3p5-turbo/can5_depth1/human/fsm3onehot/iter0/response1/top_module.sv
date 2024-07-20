module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

// Define the state transition logic
always @(*)
begin
    case(state)
        4'b0001: next_state = in ? 4'b0010 : 4'b0001; // A -> B if in=1, A -> A if in=0
        4'b0010: next_state = in ? 4'b0010 : 4'b0100; // B -> B if in=1, B -> C if in=0
        4'b0100: next_state = in ? 4'b0001 : 4'b1000; // C -> A if in=1, C -> D if in=0
        4'b1000: next_state = in ? 4'b0100 : 4'b0010; // D -> C if in=1, D -> B if in=0
    endcase
end

// Define the output logic
always @(*)
begin
    case(state)
        4'b0001: out = 1'b0; // Output 0 for state A
        4'b0010: out = 1'b0; // Output 0 for state B
        default: out = 1'b1; // Output 1 for states C and D
    endcase
end

endmodule
