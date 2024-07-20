module top_module (
	input clk,
	input areset,
	input x,
	output z
);

// Mealy machine states
parameter A = 2'b00;
parameter B = 2'b01;

reg [1:0] current_state, next_state;
reg output_z;

always@(posedge clk or posedge areset) begin
    if(areset)
        current_state <= A;
    else
        current_state <= next_state;
end

always@(current_state or x) begin
    case(current_state)
        A: begin
            if(x)
                next_state = B;
            else
                next_state = A;
            output_z = x;
        end
        B: begin
            if(x)
                next_state = B;
            else
                next_state = B;
            output_z = ~x;
        end
        default: begin
            next_state = A;
            output_z = 0;
        end
    endcase
end

assign z = output_z;

endmodule
