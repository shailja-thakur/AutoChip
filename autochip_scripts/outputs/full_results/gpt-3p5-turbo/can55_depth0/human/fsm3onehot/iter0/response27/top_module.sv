module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output reg out
);

always @* begin
    case(state)
        4'b0001: begin
            if(in) begin
                next_state = 4'b0010; // Next state in=1
            end else begin
                next_state = 4'b0001; // Next state in=0
            end
            out = 1'b0;
        end
        4'b0010: begin
            if(in) begin
                next_state = 4'b0010; // Next state in=1
            end else begin
                next_state = 4'b0100; // Next state in=0
            end
            out = 1'b0;
        end
        4'b0100: begin
            if(in) begin
                next_state = 4'b0001; // Next state in=1
            end else begin
                next_state = 4'b1000; // Next state in=0
            end
            out = 1'b0;
        end
        4'b1000: begin
            if(in) begin
                next_state = 4'b0100; // Next state in=1
            end else begin
                next_state = 4'b0010; // Next state in=0
            end
            out = 1'b1;
        end
        default: begin
            next_state = 4'bxxxx; // Invalid state
            out = 1'bx; // Unknown output
        end
    endcase
end

endmodule
