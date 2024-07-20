module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out;

always_ff @(posedge clk or posedge areset)
begin
    if (areset)
        state <= 2'b00;
    else
    begin
        case (state)
            2'b00: state <= (in) ? 2'b01 : 2'b00; // A -> A if in=0, A -> B if in=1
            2'b01: state <= (in) ? 2'b01 : 2'b10; // B -> C if in=0, B -> B if in=1
            2'b10: state <= (in) ? 2'b00 : 2'b11; // C -> A if in=0, C -> D if in=1
            2'b11: state <= (in) ? 2'b10 : 2'b01; // D -> C if in=0, D -> B if in=1
        endcase
    end
end

always_comb
begin
    case (state)
        2'b00: out = 1'b0; // A
        2'b01: out = 1'b0; // B
        2'b10: out = 1'b0; // C
        2'b11: out = 1'b1; // D
    endcase
end

endmodule
