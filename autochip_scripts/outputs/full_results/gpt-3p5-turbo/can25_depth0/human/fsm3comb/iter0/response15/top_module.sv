module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

always @* begin
    case(state)
        2'b00: begin
            if(in==1'b0) begin
                next_state = 2'b00; // A stays in A
                out = 1'b0;
            end
            else if(in==1'b1) begin
                next_state = 2'b01; // B goes to B
                out = 1'b0;
            end
        end
        2'b01: begin
            if(in==1'b0) begin
                next_state = 2'b10; // B goes to C
                out = 1'b0;
            end
            else if(in==1'b1) begin
                next_state = 2'b01; // B stays in B
                out = 1'b0;
            end
        end
        2'b10: begin
            if(in==1'b0) begin
                next_state = 2'b00; // C goes to A
                out = 1'b0;
            end
            else if(in==1'b1) begin
                next_state = 2'b11; // C goes to D
                out = 1'b0;
            end
        end
        2'b11: begin
            if(in==1'b0) begin
                next_state = 2'b10; // D goes to C
                out = 1'b1;
            end
            else if(in==1'b1) begin
                next_state = 2'b01; // D goes to B
                out = 1'b0;
            end
        end
    endcase
end

endmodule
