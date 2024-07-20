module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;
reg [1:0] next_state;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

always @(*) begin
    case(state)
        A: begin
            if (s == 0)
                next_state = A;
            else
                next_state = B;
        end
        
        B: begin
            if (w == 1)
                next_state = B;
            else if ((w == 1) + (w == 1) + (w == 0) + (w == 0) + (w == 0) + (w == 0) == 2)
                next_state = A;
            else
                next_state = B;
        end
        
        default: next_state = A;
    end
end

always @(posedge clk) begin
    if (state == B && (w == 1) + (w == 1) + (w == 0) + (w == 0) + (w == 0) + (w == 0) == 2)
        z <= 1;
    else
        z <= 0;
end

endmodule
